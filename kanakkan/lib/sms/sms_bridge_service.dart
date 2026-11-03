import 'dart:async';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../data/local/app_database.dart';
import '../data/local/daos/bank_dao.dart';
import '../data/local/daos/transaction_dao.dart';
import 'parser.dart';
import 'unreadable_store.dart';

class RawSmsMessage {
  final String sender;
  final String body;
  final DateTime receivedAt;

  const RawSmsMessage({
    required this.sender,
    required this.body,
    required this.receivedAt,
  });

  factory RawSmsMessage.fromMap(Map<dynamic, dynamic> map) {
    final sender = (map['sender'] as String?) ?? 'UNKNOWN';
    final body = (map['body'] as String?) ?? '';
    final timestampMillis = (map['timestamp'] as num?)?.toInt() ?? 0;
    final receivedAt = timestampMillis > 0
        ? DateTime.fromMillisecondsSinceEpoch(timestampMillis)
        : DateTime.now();

    return RawSmsMessage(
      sender: sender,
      body: body,
      receivedAt: receivedAt,
    );
  }
}

class SmsProcessingResult {
  final bool isProcessed;
  final bool isDuplicate;
  final bool isIgnored;
  final bool isUnreadable;
  final Transaction? insertedTransaction;
  final BalanceReconciliationResult? balanceResult;

  const SmsProcessingResult({
    required this.isProcessed,
    this.isDuplicate = false,
    this.isIgnored = false,
    this.isUnreadable = false,
    this.insertedTransaction,
    this.balanceResult,
  });
}

class SmsBridgeService {
  static const MethodChannel _methodChannel =
      MethodChannel('com.kanakkan/sms_methods');
  static const EventChannel _eventChannel =
      EventChannel('com.kanakkan/sms_stream');

  final SmsParser parser;
  final AppDatabase db;
  final BankDao bankDao;
  final TransactionDao transactionDao;
  final UnreadableStore unreadableStore;

  StreamSubscription<dynamic>? _subscription;

  SmsBridgeService({
    required this.parser,
    required this.db,
    required this.bankDao,
    required this.transactionDao,
    required this.unreadableStore,
  });

  /// Check SMS permissions
  Future<bool> checkPermissions() async {
    try {
      final bool granted =
          await _methodChannel.invokeMethod('checkPermissions') ?? false;
      return granted;
    } catch (_) {
      return false;
    }
  }

  /// Request SMS permissions
  Future<bool> requestPermissions() async {
    try {
      final bool granted =
          await _methodChannel.invokeMethod('requestPermissions') ?? false;
      return granted;
    } catch (_) {
      return false;
    }
  }

  /// Start listening to incoming real-time SMS
  void startRealtimeListener({
    void Function(SmsProcessingResult result)? onProcessed,
  }) {
    _subscription?.cancel();
    _subscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic event) async {
        if (event is Map) {
          final rawSms = RawSmsMessage.fromMap(event);
          final result = await processIncomingSms(rawSms);
          if (onProcessed != null) {
            onProcessed(result);
          }
        }
      },
      onError: (dynamic error) {
        // Stream error handling
      },
    );
  }

  /// Stop real-time listener
  void stopRealtimeListener() {
    _subscription?.cancel();
    _subscription = null;
  }

  /// Rescan SMS inbox for missed messages on app open
  Future<List<SmsProcessingResult>> scanInbox({
    DateTime? since,
    int limit = 300,
  }) async {
    try {
      final sinceTimestamp = since?.millisecondsSinceEpoch;
      final dynamic rawList = await _methodChannel.invokeMethod('scanInbox', {
        'sinceTimestamp': sinceTimestamp,
        'limit': limit,
      });

      if (rawList is! List) return [];

      final results = <SmsProcessingResult>[];
      for (final item in rawList) {
        if (item is Map) {
          final rawSms = RawSmsMessage.fromMap(item);
          final result = await processIncomingSms(rawSms);
          results.add(result);
        }
      }
      return results;
    } catch (_) {
      return [];
    }
  }

  /// Ingestion Pipeline: Parse -> Deduplicate -> Reconcile -> Persist
  Future<SmsProcessingResult> processIncomingSms(RawSmsMessage raw) async {
    final parseResult = parser.parse(
      sender: raw.sender,
      rawBody: raw.body,
      receivedAt: raw.receivedAt,
    );

    if (parseResult.isIgnoredOtpOrPromo) {
      return const SmsProcessingResult(
        isProcessed: false,
        isIgnored: true,
      );
    }

    if (!parseResult.isSuccess || parseResult.transaction == null) {
      // Quarantine to unreadable store
      unreadableStore.recordUnreadable(
        sender: raw.sender,
        body: raw.body,
        receivedAt: raw.receivedAt,
        failureReason: parseResult.unreadableReason ?? 'No matching template',
      );
      return const SmsProcessingResult(
        isProcessed: false,
        isUnreadable: true,
      );
    }

    final parsedTxn = parseResult.transaction!;

    // 1. Deduplication Check
    final dedupeHash = parsedTxn.upiRef.isNotEmpty
        ? parsedTxn.primaryDedupeHash
        : parsedTxn.fallbackDedupeHash;

    final alreadyExists = await transactionDao.hasTransactionWithHash(dedupeHash);
    if (alreadyExists) {
      return const SmsProcessingResult(
        isProcessed: false,
        isDuplicate: true,
      );
    }

    // 2. Resolve or Auto-create Account
    Account? account = await bankDao.getAccountByLast4(parsedTxn.accountDigits);
    if (account == null) {
      final newAccountId = 'acc_${parsedTxn.accountDigits}';
      await bankDao.upsertAccount(
        AccountsCompanion(
          id: Value(newAccountId),
          bankName: Value(parsedTxn.bankName),
          last4Digits: Value(parsedTxn.accountDigits),
          runningBalancePaise: Value(parsedTxn.balancePaise ?? 0),
        ),
      );
      account = await bankDao.getAccountById(newAccountId);
    }

    final accountId = account!.id;

    // 3. Balance Reconciliation Check
    final balanceResult = await transactionDao.reconcileBalance(
      accountId: accountId,
      amountPaise: parsedTxn.amountPaise,
      txnType: parsedTxn.txnType.name,
      reportedBalancePaise: parsedTxn.balancePaise,
    );

    // 4. Payee Rule Matching & Categorization
    final payeeMatch = await _matchPayee(parsedTxn.payee);

    // 5. Build Transaction Entity
    final txnId = 'txn_${DateTime.now().microsecondsSinceEpoch}';
    final txnCompanion = TransactionsCompanion(
      id: Value(txnId),
      accountId: Value(accountId),
      amountPaise: Value(parsedTxn.amountPaise),
      txnType: Value(parsedTxn.txnType.name),
      classification: Value(payeeMatch?.classification ?? 'need'),
      categoryId: Value(payeeMatch?.categoryId),
      payeeId: Value(payeeMatch?.payeeId),
      payeeName: Value(parsedTxn.payee),
      balanceAfterPaise: Value(parsedTxn.balancePaise),
      timestamp: Value(parsedTxn.effectiveDate),
      receivedAt: Value(parsedTxn.receivedDate),
      rawSmsBody: Value(raw.body),
      dedupeHash: Value(dedupeHash),
      upiRef: Value(parsedTxn.upiRef.isNotEmpty ? parsedTxn.upiRef : null),
      isFlagged: Value(parsedTxn.isDateFlagged),
      flagReason: Value(parsedTxn.isDateFlagged
          ? 'SMS date mismatched with phone received time'
          : null),
      tagStatus: Value(payeeMatch != null ? 'confirmed' : 'untagged'),
    );

    final inserted = await transactionDao.insertTransactionSafe(txnCompanion);

    return SmsProcessingResult(
      isProcessed: true,
      insertedTransaction: inserted,
      balanceResult: balanceResult,
    );
  }

  Future<_PayeeMatch?> _matchPayee(String rawPayeeName) async {
    final clean = rawPayeeName.trim().toLowerCase();
    final allPayees = await db.select(db.payees).get();

    for (final p in allPayees) {
      if (p.name.toLowerCase() == clean || p.cleanedName.toLowerCase() == clean) {
        return _PayeeMatch(
          payeeId: p.id,
          categoryId: p.defaultCategoryId,
          classification: p.defaultClassification ?? 'need',
        );
      }
    }
    return null;
  }
}

class _PayeeMatch {
  final String payeeId;
  final String? categoryId;
  final String classification;

  _PayeeMatch({
    required this.payeeId,
    this.categoryId,
    required this.classification,
  });
}
