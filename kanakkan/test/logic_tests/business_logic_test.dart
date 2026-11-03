import 'package:test/test.dart';
import 'package:kanakkan/logic/cycle/cycle_calculator.dart';
import 'package:kanakkan/logic/goals/can_i_buy_engine.dart';
import 'package:kanakkan/logic/recurring/recurring_detector.dart';
import 'package:kanakkan/logic/analytics/analytics_engine.dart';

void main() {
  group('CycleCalculator Tests', () {
    test('calculates exact daily safe pace when salary date is set', () {
      // Balance = ₹32,000 (3,200,000 paise)
      // Committed Bills = ₹10,000 (1,000,000 paise)
      // Buffer = ₹2,000 (200,000 paise)
      // Spendable pool = ₹20,000 (2,000,000 paise)
      // Days left = 10 -> Daily Safe = ₹2,000 (200,000 paise)
      final now = DateTime(2026, 11, 1);
      final nextSalary = DateTime(2026, 11, 11);

      final result = CycleCalculator.calculateDailyPace(
        availableBalancePaise: 3200000,
        billsDueBeforeSalaryPaise: 1000000,
        bufferPaise: 200000,
        expectedSalaryDate: nextSalary,
        currentDate: now,
      );

      expect(result.daysLeft, equals(10));
      expect(result.isEstimate, isFalse);
      expect(result.spendablePoolPaise, equals(2000000));
      expect(result.dailySafePaise, equals(200000)); // ₹2,000
    });

    test('assumes 30 days as estimate when salary date is not configured', () {
      final result = CycleCalculator.calculateDailyPace(
        availableBalancePaise: 3200000,
        billsDueBeforeSalaryPaise: 1000000,
        bufferPaise: 200000,
        expectedSalaryDate: null,
      );

      expect(result.daysLeft, equals(30));
      expect(result.isEstimate, isTrue);
      expect(result.dailySafePaise, equals(2000000 ~/ 30));
    });

    test('suggests next salary date based on median historical cycle gap', () {
      final currentSalary = DateTime(2026, 11, 1);
      // Previous gaps: 31 days, 30 days, 29 days -> median = 30 days
      final suggested = CycleCalculator.suggestNextSalaryDate(
        currentSalaryDate: currentSalary,
        historicalCycleGapsInDays: [31, 30, 29],
      );

      expect(suggested, equals(DateTime(2026, 12, 1)));
    });
  });

  group('CanIBuyEngine & Goal ETA Tests', () {
    test('returns YES and recalculates adjusted pace when purchase is affordable', () {
      // Free cash = 32,000 - 10,000 - 2,000 = ₹20,000
      // Purchase = ₹5,000 (500,000 paise)
      // Days until salary = 10
      // Old daily safe = ₹2,000
      // New daily safe = (20,000 - 5,000) / 10 = ₹1,500
      final result = CanIBuyEngine.evaluate(
        purchasePricePaise: 500000,
        availableBalancePaise: 3200000,
        billsDueBeforeSalaryPaise: 1000000,
        bufferPaise: 200000,
        daysUntilSalary: 10,
      );

      expect(result.status, equals(CanIBuyStatus.yes));
      expect(result.isAffordable, isTrue);
      expect(result.oldDailySafePaise, equals(200000));
      expect(result.newDailySafePaise, equals(150000));
      expect(result.shortfallPaise, isNull);
    });

    test('returns NOT YET with shortfall and wait time when item exceeds free cash', () {
      // Free cash = ₹20,000 (2,000,000 paise)
      // Purchase = ₹25,000 (2,500,000 paise) -> Shortfall = ₹5,000 (500,000 paise)
      // Monthly surplus = ₹15,000 (1,500,000 paise) -> Daily surplus = ₹500/day
      // Days to save = 5000 / 500 = 10 days
      final result = CanIBuyEngine.evaluate(
        purchasePricePaise: 2500000,
        availableBalancePaise: 3200000,
        billsDueBeforeSalaryPaise: 1000000,
        bufferPaise: 200000,
        daysUntilSalary: 10,
        monthlySurplusPaise: 1500000,
      );

      expect(result.status, equals(CanIBuyStatus.notYet));
      expect(result.isAffordable, isFalse);
      expect(result.shortfallPaise, equals(500000));
      expect(result.daysToWait, equals(10));
    });

    test('calculates sinking fund goal ETA in months accurately', () {
      // Goal = ₹1,20,000 (12,000,000 paise), Saved = ₹20,000 (2,000,000 paise)
      // Remaining = ₹1,00,000
      // Monthly surplus = ₹25,000 (2,500,000 paise) -> 4.0 months
      final eta = CanIBuyEngine.calculateGoalEtaMonths(
        targetPaise: 12000000,
        savedPaise: 2000000,
        monthlySurplusPaise: 2500000,
      );

      expect(eta, equals(4.0));
    });
  });

  group('RecurringDetector Tests', () {
    test('confirms monthly subscription after 3 regular sightings', () {
      final txns = [
        TransactionRecord(
          payee: 'Netflix Entertainment',
          amountPaise: 64900, // ₹649
          date: DateTime(2026, 8, 5),
        ),
        TransactionRecord(
          payee: 'Netflix Entertainment',
          amountPaise: 64900,
          date: DateTime(2026, 9, 4), // 30 days gap
        ),
        TransactionRecord(
          payee: 'Netflix Entertainment',
          amountPaise: 64900,
          date: DateTime(2026, 10, 4), // 30 days gap
        ),
      ];

      final detected = RecurringDetector.detect(transactions: txns);

      expect(detected.length, equals(1));
      final bill = detected.first;
      expect(bill.status, equals(RecurringStatus.confirmed));
      expect(bill.cadence, equals(RecurringCadence.monthly));
      expect(bill.isVariable, isFalse);
      expect(bill.medianAmountPaise, equals(64900));
    });

    test('detects variable utility bill within ±25% tolerance as possible with 2 sightings', () {
      final txns = [
        TransactionRecord(
          payee: 'BESCOM Electricity',
          amountPaise: 200000, // ₹2,000
          date: DateTime(2026, 9, 10),
        ),
        TransactionRecord(
          payee: 'BESCOM Electricity',
          amountPaise: 230000, // ₹2,300 (+15% variance)
          date: DateTime(2026, 10, 10), // 30 days gap
        ),
      ];

      final detected = RecurringDetector.detect(transactions: txns);

      expect(detected.length, equals(1));
      final bill = detected.first;
      expect(bill.status, equals(RecurringStatus.possible));
      expect(bill.isVariable, isTrue);
    });

    test('excludes daily chai / micro-spends from recurring bills', () {
      final txns = [
        TransactionRecord(
          payee: 'Sharma Tea Stall',
          amountPaise: 4000, // ₹40
          date: DateTime(2026, 11, 1),
        ),
        TransactionRecord(
          payee: 'Sharma Tea Stall',
          amountPaise: 4000,
          date: DateTime(2026, 11, 2),
        ),
        TransactionRecord(
          payee: 'Sharma Tea Stall',
          amountPaise: 4000,
          date: DateTime(2026, 11, 3),
        ),
      ];

      final detected = RecurringDetector.detect(transactions: txns);
      // Daily chai micro-spends are ignored by recurring bill detector
      expect(detected.isEmpty, isTrue);
    });

    test('flags missed bill if not seen 5 days after due date', () {
      final dueDate = DateTime(2026, 11, 1);
      final current4DaysLater = DateTime(2026, 11, 5);
      final current6DaysLater = DateTime(2026, 11, 7);

      expect(
        RecurringDetector.isPaymentMissed(
          nextDueDate: dueDate,
          currentDate: current4DaysLater,
        ),
        isFalse,
      );

      expect(
        RecurringDetector.isPaymentMissed(
          nextDueDate: dueDate,
          currentDate: current6DaysLater,
        ),
        isTrue,
      );
    });
  });

  group('AnalyticsEngine Tests', () {
    test('computes 50/30/20 envelope breakdown accurately', () {
      final breakdown = AnalyticsEngine.computeEnvelopeBreakdown(
        needsPaise: 5000000, // ₹50,000
        wantsPaise: 3000000, // ₹30,000
        savingsPaise: 2000000, // ₹20,000
      );

      expect(breakdown.totalSpentPaise, equals(10000000));
      expect(breakdown.needsPercentage, equals(50.0));
      expect(breakdown.wantsPercentage, equals(30.0));
      expect(breakdown.savingsPercentage, equals(20.0));
    });

    test('aggregates Chai Factor for spends under ₹100', () {
      final debits = [
        4000, // ₹40
        6000, // ₹60
        8000, // ₹80
        50000, // ₹500
        120000, // ₹1,200
      ];

      final insight = AnalyticsEngine.computeChaiFactor(debitsPaise: debits);

      expect(insight.totalCount, equals(3));
      expect(insight.totalPaise, equals(18000)); // ₹180
      expect(insight.averageSpendPaise, equals(6000)); // ₹60
    });

    test('evaluates spending burn velocity pace correctly', () {
      // Total budget = ₹30,000 (3,000,000 paise) across 30 days -> ₹1,000/day expected
      // On day 10, expected burn = ₹10,000 (±10% is 9,000 - 11,000)

      expect(
        AnalyticsEngine.evaluatePace(
          spentSoFarPaise: 700000, // ₹7,000
          totalSpendableBudgetPaise: 3000000,
          daysElapsed: 10,
          totalCycleDays: 30,
        ),
        equals(PaceStatus.underpace),
      );

      expect(
        AnalyticsEngine.evaluatePace(
          spentSoFarPaise: 1050000, // ₹10,500
          totalSpendableBudgetPaise: 3000000,
          daysElapsed: 10,
          totalCycleDays: 30,
        ),
        equals(PaceStatus.onPace),
      );

      expect(
        AnalyticsEngine.evaluatePace(
          spentSoFarPaise: 1400000, // ₹14,000
          totalSpendableBudgetPaise: 3000000,
          daysElapsed: 10,
          totalCycleDays: 30,
        ),
        equals(PaceStatus.overpace),
      );
    });
  });
}

