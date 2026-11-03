import 'package:test/test.dart';
import 'package:kanakkan/core/utils/currency_utils.dart';
import 'package:kanakkan/sms/dedupe.dart';
import 'package:kanakkan/sms/parser.dart';
import 'package:kanakkan/sms/template_model.dart';
import 'package:kanakkan/sms/templates/canara_templates.dart';

void main() {
  late SmsParser parser;

  setUp(() {
    parser = SmsParser(activeTemplates: CanaraTemplates.allSeedTemplates);
  });

  group('CurrencyUtils & Paise Precision Tests', () {
    test('converts various Indian currency strings to exact paise', () {
      expect(CurrencyUtils.parseRupeesToPaise('40'), equals(4000));
      expect(CurrencyUtils.parseRupeesToPaise('40.50'), equals(4050));
      expect(CurrencyUtils.parseRupeesToPaise('INR 12,600.00'), equals(1260000));
      expect(CurrencyUtils.parseRupeesToPaise('Rs.1,25,000'), equals(12500000));
      expect(CurrencyUtils.parseRupeesToPaise('₹3,850.25'), equals(385025));
    });

    test('formats paise to Indian number system strings', () {
      expect(CurrencyUtils.formatPaise(1260000), equals('₹12,600'));
      expect(CurrencyUtils.formatPaise(12500000), equals('₹1,25,000'));
      expect(CurrencyUtils.formatPaise(4050, showDecimals: true), equals('₹40.50'));
      expect(CurrencyUtils.formatPaise(-200000), equals('-₹2,000'));
    });
  });

  group('Canara Bank UPI Debit Template Tests', () {
    test('successfully parses official Canara UPI debit with balance', () {
      const rawSms =
          'Dear Customer, INR 450.00 debited from A/c ..1234 to Sharma Tea Stall on 03/11/2026 via UPI Ref 430291823812. Avail Bal: Rs.32,400.00. Do not share OTP.';
      final receivedAt = DateTime(2026, 11, 3, 16, 15);

      final result = parser.parse(
        sender: 'VM-CANBNK',
        rawBody: rawSms,
        receivedAt: receivedAt,
      );

      expect(result.isSuccess, isTrue);
      final txn = result.transaction!;

      expect(txn.amountPaise, equals(45000)); // ₹450.00
      expect(txn.accountDigits, equals('1234'));
      expect(txn.payee, equals('Sharma Tea Stall'));
      expect(txn.upiRef, equals('430291823812'));
      expect(txn.balancePaise, equals(3240000)); // ₹32,400.00
      expect(txn.txnType, equals(TransactionType.debit));
      expect(txn.bankName, equals('Canara Bank'));
      expect(txn.isDateFlagged, isFalse);
      expect(txn.isFallbackGuess, isFalse);
    });

    test('flags transaction when parsed date disagrees with received date', () {
      // SMS text says 01/10/2026, but phone received time is 03/11/2026
      const rawSms =
          'Dear Customer, INR 1,420.00 debited from A/c ..1234 to Nature Basket on 01/10/2026 via UPI Ref 430291823999. Bal: Rs.28,000.00.';
      final receivedAt = DateTime(2026, 11, 3, 10, 30);

      final result = parser.parse(
        sender: 'VK-CANBNK',
        rawBody: rawSms,
        receivedAt: receivedAt,
      );

      expect(result.isSuccess, isTrue);
      final txn = result.transaction!;

      expect(txn.amountPaise, equals(142000));
      expect(txn.isDateFlagged, isTrue);
      // Effective date must strictly follow phone received date
      expect(txn.effectiveDate, equals(receivedAt));
    });
  });

  group('Canara Bank UPI Credit Template Tests (Zero-Assumption Income)', () {
    test('successfully parses Canara UPI credit without balance', () {
      const rawSms =
          'Dear Customer, A/c ..1234 is credited with INR 45,000.00 on 11/01/2026 21:29:15 by UPI Ref 430291899999 from Employer Corp. Call 18004250018 for dispute.';
      final receivedAt = DateTime(2026, 11, 1, 21, 30);

      final result = parser.parse(
        sender: 'CANBNK',
        rawBody: rawSms,
        receivedAt: receivedAt,
      );

      expect(result.isSuccess, isTrue);
      final txn = result.transaction!;

      expect(txn.amountPaise, equals(4500000)); // ₹45,000.00
      expect(txn.accountDigits, equals('1234'));
      expect(txn.upiRef, equals('430291899999'));
      // Canara credit template carries NO balance
      expect(txn.balancePaise, isNull);
      expect(txn.txnType, equals(TransactionType.credit));
    });
  });

  group('OTP and Promotional Filters', () {
    test('ignores OTP messages', () {
      const otpSms =
          'Your OTP for NetBanking login is 839201. Valid for 5 mins. Do not share OTP with anyone - Canara Bank.';
      final result = parser.parse(
        sender: 'VM-CANBNK',
        rawBody: otpSms,
        receivedAt: DateTime.now(),
      );

      expect(result.isSuccess, isFalse);
      expect(result.isIgnoredOtpOrPromo, isTrue);
    });

    test('ignores promotional and marketing notices', () {
      const promoSms =
          'Dear Customer, your reward points 450 on Canara Bank Card **1234 are expiring on 31-Oct. Redeem now at netbanking.';
      final result = parser.parse(
        sender: 'VM-CANBNK',
        rawBody: promoSms,
        receivedAt: DateTime.now(),
      );

      expect(result.isSuccess, isFalse);
      expect(result.isIgnoredOtpOrPromo, isTrue);
    });
  });

  group('Fallback Keyword Heuristic Parser Tests (Unknown Banks)', () {
    test('extracts debit transaction from unknown bank using keywords', () {
      const unknownBankSms =
          'HDFC Bank: Rs 850.00 debited from a/c **5678 to Blue Tokai on 03-Nov-26 via UPI Ref 9988776655. Avail Bal INR 15,200.00';
      final receivedAt = DateTime(2026, 11, 3, 14, 20);

      final result = parser.parse(
        sender: 'HDFCBK',
        rawBody: unknownBankSms,
        receivedAt: receivedAt,
      );

      expect(result.isSuccess, isTrue);
      final txn = result.transaction!;

      expect(txn.amountPaise, equals(85000)); // ₹850.00
      expect(txn.accountDigits, equals('5678'));
      expect(txn.payee, contains('Blue Tokai'));
      expect(txn.upiRef, equals('9988776655'));
      expect(txn.balancePaise, equals(1520000));
      expect(txn.isFallbackGuess, isTrue);
    });
  });

  group('Deduplication Keys', () {
    test('generates consistent primary hash for identical ref, account, amount', () {
      final hash1 = DedupeEngine.computePrimaryKey(
        upiRef: '430291823812',
        accountDigits: '1234',
        amountPaise: 45000,
      );
      final hash2 = DedupeEngine.computePrimaryKey(
        upiRef: '430291823812',
        accountDigits: '1234',
        amountPaise: 45000,
      );
      final hash3 = DedupeEngine.computePrimaryKey(
        upiRef: 'DIFF_REF',
        accountDigits: '1234',
        amountPaise: 45000,
      );

      expect(hash1, equals(hash2));
      expect(hash1, isNot(equals(hash3)));
    });

    test('generates fallback key when reference is missing', () {
      final date = DateTime(2026, 11, 3);
      final fallback1 = DedupeEngine.computeFallbackKey(
        amountPaise: 45000,
        payee: 'Sharma Tea Stall',
        date: date,
        balancePaise: 3240000,
      );
      final fallback2 = DedupeEngine.computeFallbackKey(
        amountPaise: 45000,
        payee: 'sharma tea stall ', // spacing and case normalization
        date: date,
        balancePaise: 3240000,
      );

      expect(fallback1, equals(fallback2));
    });
  });
}
