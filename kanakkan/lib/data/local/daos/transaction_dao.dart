import 'package:drift/drift.dart';
import 'package:kanakkan/core/utils/currency_utils.dart';
import '../app_database.dart';

class BalanceReconciliationResult {
  final bool isAccurate;
  final int unaccountedPaise;
  final String message;

  const BalanceReconciliationResult({
    required this.isAccurate,
    required this.unaccountedPaise,
    required this.message,
  });
}

class TransactionDao {
  final AppDatabase db;

  TransactionDao(this.db);

  /// Check whether a transaction with the same deduplication hash already exists
  Future<bool> hasTransactionWithHash(String dedupeHash) async {
    final query = db.select(db.transactions)
      ..where((tbl) => tbl.dedupeHash.equals(dedupeHash));
    final match = await query.getSingleOrNull();
    return match != null;
  }

  /// Insert a new parsed transaction and update account balance if balance info is available.
  /// Returns the inserted Transaction, or null if duplicate.
  Future<Transaction?> insertTransactionSafe(TransactionsCompanion txn) async {
    final dedupeHash = txn.dedupeHash.value;
    final exists = await hasTransactionWithHash(dedupeHash);
    if (exists) {
      return null;
    }

    final inserted = await db.into(db.transactions).insertReturning(txn);

    // If transaction reports a balance, update the account running balance
    if (txn.balanceAfterPaise.present && txn.balanceAfterPaise.value != null) {
      final accountId = txn.accountId.value;
      await (db.update(db.accounts)..where((tbl) => tbl.id.equals(accountId))).write(
        AccountsCompanion(
          runningBalancePaise: Value(txn.balanceAfterPaise.value!),
        ),
      );
    }

    return inserted;
  }

  /// Balance check logic:
  /// Compares reported SMS balance with the app's calculated balance.
  /// Debits carry a balance. Credits carry no balance, so a missed credit shows up at the next debit.
  Future<BalanceReconciliationResult> reconcileBalance({
    required String accountId,
    required int amountPaise,
    required String txnType, // 'debit' or 'credit'
    required int? reportedBalancePaise,
  }) async {
    if (reportedBalancePaise == null) {
      // Credits carry no balance, so we cannot check yet
      return const BalanceReconciliationResult(
        isAccurate: true,
        unaccountedPaise: 0,
        message: 'No balance reported in SMS',
      );
    }

    final account = await (db.select(db.accounts)
          ..where((tbl) => tbl.id.equals(accountId)))
        .getSingleOrNull();

    if (account == null || account.runningBalancePaise == 0) {
      // First transaction for this account, establish initial baseline
      return const BalanceReconciliationResult(
        isAccurate: true,
        unaccountedPaise: 0,
        message: 'Baseline established',
      );
    }

    final previousBalance = account.runningBalancePaise;
    final expectedBalance = txnType == 'debit'
        ? (previousBalance - amountPaise)
        : (previousBalance + amountPaise);

    final discrepancy = expectedBalance - reportedBalancePaise;

    if (discrepancy == 0) {
      return const BalanceReconciliationResult(
        isAccurate: true,
        unaccountedPaise: 0,
        message: 'Balanced',
      );
    } else {
      final formattedDiff = CurrencyUtils.formatPaise(discrepancy.abs());
      final direction = discrepancy > 0 ? 'unaccounted spend' : 'unaccounted credit';
      return BalanceReconciliationResult(
        isAccurate: false,
        unaccountedPaise: discrepancy,
        message: '$formattedDiff $direction detected',
      );
    }
  }

  /// Retrieve untagged transactions queue (What for? queue)
  Future<List<Transaction>> getUntaggedTransactions() {
    return (db.select(db.transactions)
          ..where((tbl) => tbl.tagStatus.equals('untagged'))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)]))
        .get();
  }

  Stream<List<Transaction>> watchUntaggedTransactions() {
    return (db.select(db.transactions)
          ..where((tbl) => tbl.tagStatus.equals('untagged'))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)]))
        .watch();
  }

  /// Watch recent transactions for feed
  Stream<List<Transaction>> watchRecentTransactions({int limit = 50}) {
    return (db.select(db.transactions)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)])
          ..limit(limit))
        .watch();
  }

  /// Fetch transactions within an active salary cycle
  Future<List<Transaction>> getTransactionsForCycle(String cycleId) {
    return (db.select(db.transactions)
          ..where((tbl) => tbl.cycleId.equals(cycleId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.timestamp)]))
        .get();
  }

  /// Update transaction tagging
  Future<void> updateTransactionTag({
    required String transactionId,
    String? categoryId,
    String? payeeId,
    String? classification, // 'need', 'want'
    required String tagStatus, // 'confirmed', 'guessed'
  }) {
    return (db.update(db.transactions)..where((tbl) => tbl.id.equals(transactionId)))
        .write(
      TransactionsCompanion(
        categoryId: categoryId != null ? Value(categoryId) : const Value.absent(),
        payeeId: payeeId != null ? Value(payeeId) : const Value.absent(),
        classification: classification != null
            ? Value(classification)
            : const Value.absent(),
        tagStatus: Value(tagStatus),
      ),
    );
  }
}
