import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:test/test.dart';

import 'package:kanakkan/data/local/app_database.dart';
import 'package:kanakkan/data/local/daos/bank_dao.dart';
import 'package:kanakkan/data/local/daos/transaction_dao.dart';
import 'package:kanakkan/data/local/database_seeder.dart';
import 'package:kanakkan/sms/dedupe.dart';
import 'package:kanakkan/sms/parser.dart';

void main() {
  late AppDatabase db;
  late BankDao bankDao;
  late TransactionDao transactionDao;
  late DatabaseSeeder seeder;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    bankDao = BankDao(db);
    transactionDao = TransactionDao(db);
    seeder = DatabaseSeeder(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Database Seeder & Dynamic Templates Tests', () {
    test('seeds initial Canara Bank and active templates into SQLite', () async {
      await seeder.seedInitialData();

      final banks = await bankDao.getAllBanks();
      expect(banks.length, equals(1));
      expect(banks.first.name, equals('Canara Bank'));

      final templates = await bankDao.getActiveTemplates();
      expect(templates.length, equals(2)); // Debit & Credit

      // Verify categories seeded
      final categories = await db.select(db.categories).get();
      expect(categories.length, equals(11));
      expect(categories.any((c) => c.id == 'cat_groceries'), isTrue);

      // Verify settings seeded
      final settings = await db.select(db.userSettings).get();
      expect(settings.any((s) => s.settingKey == 'buffer_paise'), isTrue);
    });

    test('parser successfully parses SMS using dynamically retrieved DB templates', () async {
      await seeder.seedInitialData();
      final activeTemplates = await bankDao.getActiveTemplates();

      final dynamicParser = SmsParser(activeTemplates: activeTemplates);
      const rawSms =
          'Dear Customer, INR 450.00 debited from A/c ..1234 to Sharma Tea Stall on 03/11/2026 via UPI Ref 430291823812. Avail Bal: Rs.32,400.00. Do not share OTP.';
      final result = dynamicParser.parse(
        sender: 'VM-CANBNK',
        rawBody: rawSms,
        receivedAt: DateTime(2026, 11, 3, 16, 15),
      );

      expect(result.isSuccess, isTrue);
      expect(result.transaction!.amountPaise, equals(45000));
      expect(result.transaction!.balancePaise, equals(3240000));
    });
  });

  group('Transaction Deduplication & Safe Insertion', () {
    test('rejects duplicate transaction with identical dedupe hash', () async {
      await seeder.seedInitialData();

      // Create an account
      await bankDao.upsertAccount(
        const AccountsCompanion(
          id: Value('acc_1234'),
          bankId: Value('bank_canara'),
          bankName: Value('Canara Bank'),
          last4Digits: Value('1234'),
          runningBalancePaise: Value(3285000),
        ),
      );

      final dedupeHash = DedupeEngine.computePrimaryKey(
        upiRef: '430291823812',
        accountDigits: '1234',
        amountPaise: 45000,
      );

      final txnCompanion = TransactionsCompanion(
        id: const Value('txn_001'),
        accountId: const Value('acc_1234'),
        amountPaise: const Value(45000),
        txnType: const Value('debit'),
        payeeName: const Value('Sharma Tea Stall'),
        timestamp: Value(DateTime(2026, 11, 3, 16, 15)),
        receivedAt: Value(DateTime(2026, 11, 3, 16, 15)),
        rawSmsBody: const Value('Sample SMS'),
        dedupeHash: Value(dedupeHash),
        balanceAfterPaise: const Value(3240000),
      );

      // First insert succeeds
      final inserted = await transactionDao.insertTransactionSafe(txnCompanion);
      expect(inserted, isNotNull);
      expect(inserted!.id, equals('txn_001'));

      // Account balance automatically updated to 3240000
      final updatedAccount = await bankDao.getAccountById('acc_1234');
      expect(updatedAccount!.runningBalancePaise, equals(3240000));

      // Attempting to insert duplicate with same hash fails safely
      final duplicateInsert = await transactionDao.insertTransactionSafe(
        txnCompanion.copyWith(id: const Value('txn_002')),
      );
      expect(duplicateInsert, isNull);
    });
  });

  group('Balance Reconciliation & Discrepancy Detection', () {
    test('reconciles exact matching balance without discrepancy', () async {
      await seeder.seedInitialData();
      await bankDao.upsertAccount(
        const AccountsCompanion(
          id: Value('acc_1234'),
          bankId: Value('bank_canara'),
          bankName: Value('Canara Bank'),
          last4Digits: Value('1234'),
          runningBalancePaise: Value(3285000), // ₹32,850.00
        ),
      );

      // Spend ₹450 -> Expected = ₹32,400
      final result = await transactionDao.reconcileBalance(
        accountId: 'acc_1234',
        amountPaise: 45000,
        txnType: 'debit',
        reportedBalancePaise: 3240000,
      );

      expect(result.isAccurate, isTrue);
      expect(result.unaccountedPaise, equals(0));
      expect(result.message, equals('Balanced'));
    });

    test('flags unaccounted spend when bank balance is lower than calculated', () async {
      await seeder.seedInitialData();
      await bankDao.upsertAccount(
        const AccountsCompanion(
          id: Value('acc_1234'),
          bankId: Value('bank_canara'),
          bankName: Value('Canara Bank'),
          last4Digits: Value('1234'),
          runningBalancePaise: Value(3285000), // ₹32,850.00
        ),
      );

      // Debit ₹450, expected = ₹32,400.00
      // But reported is ₹31,400.00 (discrepancy of ₹1,000 unaccounted spend)
      final result = await transactionDao.reconcileBalance(
        accountId: 'acc_1234',
        amountPaise: 45000,
        txnType: 'debit',
        reportedBalancePaise: 3140000,
      );

      expect(result.isAccurate, isFalse);
      expect(result.unaccountedPaise, equals(100000)); // ₹1,000.00
      expect(result.message, contains('₹1,000 unaccounted spend detected'));
    });
  });
}
