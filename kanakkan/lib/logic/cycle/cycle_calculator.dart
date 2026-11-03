class DailyPaceResult {
  final int dailySafePaise;
  final int daysLeft;
  final bool isEstimate;
  final int availableBalancePaise;
  final int committedBillsPaise;
  final int bufferPaise;
  final int spendablePoolPaise;

  const DailyPaceResult({
    required this.dailySafePaise,
    required this.daysLeft,
    required this.isEstimate,
    required this.availableBalancePaise,
    required this.committedBillsPaise,
    required this.bufferPaise,
    required this.spendablePoolPaise,
  });
}

class CycleCalculator {
  /// Calculate the daily safe-to-spend amount:
  /// Daily safe = (Available Balance - Bills Due Before Next Salary - Buffer) / Days Left
  /// If no date is set, assume 30 days and mark as estimate.
  static DailyPaceResult calculateDailyPace({
    required int availableBalancePaise,
    required int billsDueBeforeSalaryPaise,
    required int bufferPaise,
    DateTime? expectedSalaryDate,
    DateTime? currentDate,
  }) {
    final now = currentDate ?? DateTime.now();

    int daysLeft;
    bool isEstimate;

    if (expectedSalaryDate != null) {
      final diff = expectedSalaryDate.difference(DateTime(now.year, now.month, now.day)).inDays;
      daysLeft = diff > 0 ? diff : 1;
      isEstimate = false;
    } else {
      daysLeft = 30;
      isEstimate = true;
    }

    final spendablePool = availableBalancePaise - billsDueBeforeSalaryPaise - bufferPaise;
    final dailySafe = spendablePool > 0 ? (spendablePool ~/ daysLeft) : 0;

    return DailyPaceResult(
      dailySafePaise: dailySafe,
      daysLeft: daysLeft,
      isEstimate: isEstimate,
      availableBalancePaise: availableBalancePaise,
      committedBillsPaise: billsDueBeforeSalaryPaise,
      bufferPaise: bufferPaise,
      spendablePoolPaise: spendablePool,
    );
  }

  /// Suggest next expected salary date based on previous cycle gaps
  /// Defaults to 30 days if no history is provided.
  static DateTime suggestNextSalaryDate({
    required DateTime currentSalaryDate,
    List<int> historicalCycleGapsInDays = const [],
  }) {
    if (historicalCycleGapsInDays.isEmpty) {
      return currentSalaryDate.add(const Duration(days: 30));
    }

    final sortedGaps = List<int>.from(historicalCycleGapsInDays)..sort();
    final medianGap = sortedGaps[sortedGaps.length ~/ 2];

    return currentSalaryDate.add(Duration(days: medianGap));
  }
}

