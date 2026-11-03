import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:test/test.dart';

import 'package:kanakkan/data/local/app_database.dart';
import 'package:kanakkan/data/local/daos/bank_dao.dart';
import 'package:kanakkan/data/local/daos/transaction_dao.dart';
import 'package:kanakkan/data/local/database_seeder.dart';
import 'package:kanakkan/sms/parser.dart';
import 'package:kanakkan/sms/sms_bridge_service.dart';
import 'package:kanakkan/sms/unreadable_store.dart';

void main() {
  late AppDatabase db;
  late BankDao bankDao;
  late TransactionDao transactionDao;
  late UnreadableStore unreadableStore;
  late SmsParser parser;
  late SmsBridgeService bridgeService;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    bankDao = BankDao(db);
    transactionDao = TransactionDao(db);
    unreadableStore = UnreadableStore();

    final seeder = DatabaseSeeder(db);
    await seeder.seedInitialData();

    final templates = await bankDao.getActiveTemplates();
    parser = SmsParser(activeTemplates: templates);

    bridgeService = SmsBridgeService(
      parser: parser,
      db: db,
      bankDao: bankDao,
      transactionDao: transactionDao,
      unreadableStore: unreadableStore,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('SmsBridgeService Ingestion Pipeline Tests', () {
    test('successfully processes valid Canara debit SMS and auto-creates account', () async {
      final raw = RawSmsMessage(
        sender: 'VM-CANBNK',
        body:
            'Dear Customer, INR 450.00 debited from A/c ..1234 to Sharma Tea Stall on 03/11/2026 via UPI Ref 430291823812. Avail Bal: Rs.32,400.00. Do not share OTP.',
        receivedAt: DateTime(2026, 11, 3, 16, 15),
      );

      final result = await bridgeService.processIncomingSms(raw);

      expect(result.isProcessed, isTrue);
      expect(result.isDuplicate, isFalse);
      expect(result.insertedTransaction, isNotNull);
      expect(result.insertedTransaction!.amountPaise, equals(45000));
      expect(result.insertedTransaction!.tagStatus, equals('untagged')); // Unknown payee

      // Verify account was created
      final account = await bankDao.getAccountByLast4('1234');
      expect(account, isNotNull);
      expect(account!.runningBalancePaise, equals(3240000));
    });

    test('suppresses duplicate SMS with identical UPI Ref & account', () async {
      final raw = RawSmsMessage(
        sender: 'VM-CANBNK',
        body:
            'Dear Customer, INR 450.00 debited from A/c ..1234 to Sharma Tea Stall on 03/11/2026 via UPI Ref 430291823812. Avail Bal: Rs.32,400.00. Do not share OTP.',
        receivedAt: DateTime(2026, 11, 3, 16, 15),
      );

      final first = await bridgeService.processIncomingSms(raw);
      expect(first.isProcessed, isTrue);

      final second = await bridgeService.processIncomingSms(raw);
      expect(second.isProcessed, isFalse);
      expect(second.isDuplicate, isTrue);

      // Verify database contains only 1 transaction
      final allTxns = await db.select(db.transactions).get();
      expect(allTxns.length, equals(1));
    });

    test('suppresses OTP messages and ignores them without database write', () async {
      final rawOtp = RawSmsMessage(
        sender: 'VM-CANBNK',
        body: 'Your OTP for login is 987654. Do not share.',
        receivedAt: DateTime.now(),
      );

      final result = await bridgeService.processIncomingSms(rawOtp);
      expect(result.isProcessed, isFalse);
      expect(result.isIgnored, isTrue);

      final allTxns = await db.select(db.transactions).get();
      expect(allTxns.isEmpty, isTrue);
    });

    test('quarantines unreadable bank message into UnreadableStore', () async {
      final unreadable = RawSmsMessage(
        sender: 'CANBNK',
        body: 'Some unknown format message from Canara Bank with random text.',
        receivedAt: DateTime.now(),
      );

      final result = await bridgeService.processIncomingSms(unreadable);
      expect(result.isProcessed, isFalse);
      expect(result.isUnreadable, isTrue);
      expect(unreadableStore.items.length, equals(1));
      expect(unreadableStore.items.first.sender, equals('CANBNK'));
    });

    test('auto-tags transaction when payee matches existing payee rule', () async {
      // Pre-seed a known payee
      await db.into(db.payees).insert(
            const PayeesCompanion(
              id: Value('payee_nature_basket'),
              name: Value('Nature Basket'),
              cleanedName: Value('nature basket'),
              keywordPatterns: Value('["nature basket"]'),
              defaultCategoryId: Value('cat_groceries'),
              defaultClassification: Value('need'),
            ),
          );

      final raw = RawSmsMessage(
        sender: 'VM-CANBNK',
        body:
            'Dear Customer, INR 1,200.00 debited from A/c ..1234 to Nature Basket on 03/11/2026 via UPI Ref 990011223344. Avail Bal: Rs.31,200.00.',
        receivedAt: DateTime(2026, 11, 3, 17, 0),
      );

      final result = await bridgeService.processIncomingSms(raw);

      expect(result.isProcessed, isTrue);
      expect(result.insertedTransaction!.tagStatus, equals('confirmed'));
      expect(result.insertedTransaction!.categoryId, equals('cat_groceries'));
      expect(result.insertedTransaction!.classification, equals('need'));
    });
  });
}

