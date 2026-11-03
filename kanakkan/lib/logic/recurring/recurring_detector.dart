enum RecurringCadence {
  weekly(7),
  biweekly(14),
  monthly(30),
  annual(365);

  final int days;
  const RecurringCadence(this.days);
}

enum RecurringStatus { possible, confirmed, dismissed }

class RecurringCandidate {
  final String payeeName;
  final int medianAmountPaise;
  final RecurringCadence cadence;
  final bool isVariable;
  final RecurringStatus status;
  final int sightingCount;
  final DateTime lastObservedDate;
  final DateTime nextDueDate;

  const RecurringCandidate({
    required this.payeeName,
    required this.medianAmountPaise,
    required this.cadence,
    required this.isVariable,
    required this.status,
    required this.sightingCount,
    required this.lastObservedDate,
    required this.nextDueDate,
  });
}

class TransactionRecord {
  final String payee;
  final int amountPaise;
  final DateTime date;

  const TransactionRecord({
    required this.payee,
    required this.amountPaise,
    required this.date,
  });
}

class RecurringDetector {
  static const int defaultDaysTolerance = 3;
  static const double fixedBillTolerancePct = 0.10; // ±10%
  static const double variableBillTolerancePct = 0.25; // ±25%
  static const int smallSpendDailyThresholdPaise = 10000; // ₹100 (Chai factor)

  /// Scans a chronological list of debit transactions for recurring patterns.
  static List<RecurringCandidate> detect({
    required List<TransactionRecord> transactions,
    int smallSpendThresholdPaise = smallSpendDailyThresholdPaise,
  }) {
    // 1. Group by normalized payee
    final Map<String, List<TransactionRecord>> byPayee = {};
    for (final txn in transactions) {
      final key = txn.payee.trim().toLowerCase();
      byPayee.putIfAbsent(key, () => []).add(txn);
    }

    final List<RecurringCandidate> candidates = [];

    byPayee.forEach((cleanPayee, txns) {
      // Need at least 2 transactions to detect cadence
      if (txns.length < 2) return;

      // Filter out micro frequent spends (e.g. tea/coffee < ₹100)
      final avgAmount =
          txns.map((t) => t.amountPaise).reduce((a, b) => a + b) ~/ txns.length;
      if (avgAmount < smallSpendThresholdPaise) {
        return; // Excluded as frequent small spend
      }

      // Sort chronologically
      txns.sort((a, b) => a.date.compareTo(b.date));

      // Calculate gaps between consecutive debits
      final List<int> intervals = [];
      for (int i = 0; i < txns.length - 1; i++) {
        final diffDays = txns[i + 1].date.difference(txns[i].date).inDays;
        intervals.add(diffDays);
      }

      // Match cadence: 7, 14, 30, 365 (±3 days)
      final cadence = _findMatchingCadence(intervals);
      if (cadence == null) return;

      // Calculate median amount
      final sortedAmounts = txns.map((t) => t.amountPaise).toList()..sort();
      final medianAmount = sortedAmounts[sortedAmounts.length ~/ 2];

      // Check amount variance: fixed ±10% vs variable ±25%
      final isVariable = _checkIfVariable(
        amounts: sortedAmounts,
        medianAmount: medianAmount,
      );

      final status = txns.length >= 3
          ? RecurringStatus.confirmed
          : RecurringStatus.possible;

      final lastDate = txns.last.date;
      final nextDueDate = lastDate.add(Duration(days: cadence.days));

      candidates.add(
        RecurringCandidate(
          payeeName: txns.first.payee,
          medianAmountPaise: medianAmount,
          cadence: cadence,
          isVariable: isVariable,
          status: status,
          sightingCount: txns.length,
          lastObservedDate: lastDate,
          nextDueDate: nextDueDate,
        ),
      );
    });

    return candidates;
  }

  /// Check if an expected recurring payment is missed (not seen 5 days after due date)
  static bool isPaymentMissed({
    required DateTime nextDueDate,
    required DateTime currentDate,
    int missedGraceDays = 5,
  }) {
    final diff = currentDate.difference(nextDueDate).inDays;
    return diff > missedGraceDays;
  }

  /// Check if a newly observed transaction amount has deviated significantly from the median
  static bool isAmountAnomalous({
    required int observedAmountPaise,
    required int medianAmountPaise,
    required bool isVariable,
  }) {
    final tolerance = isVariable ? variableBillTolerancePct : fixedBillTolerancePct;
    final minAllowed = (medianAmountPaise * (1.0 - tolerance)).floor();
    final maxAllowed = (medianAmountPaise * (1.0 + tolerance)).ceil();

    return observedAmountPaise < minAllowed || observedAmountPaise > maxAllowed;
  }

  static RecurringCadence? _findMatchingCadence(List<int> intervals) {
    for (final cadence in RecurringCadence.values) {
      bool allMatch = true;
      for (final interval in intervals) {
        if ((interval - cadence.days).abs() > defaultDaysTolerance) {
          allMatch = false;
          break;
        }
      }
      if (allMatch) return cadence;
    }
    return null;
  }

  static bool _checkIfVariable({
    required List<int> amounts,
    required int medianAmount,
  }) {
    for (final amt in amounts) {
      final diffRatio = (amt - medianAmount).abs() / medianAmount;
      if (diffRatio > fixedBillTolerancePct && diffRatio <= variableBillTolerancePct) {
        return true;
      }
    }
    return false;
  }
}

