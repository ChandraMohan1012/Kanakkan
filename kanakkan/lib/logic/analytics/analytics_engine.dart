enum PaceStatus { underpace, onPace, overpace }

class EnvelopeBreakdown {
  final int needsPaise;
  final int wantsPaise;
  final int savingsPaise;
  final int totalSpentPaise;
  final double needsPercentage;
  final double wantsPercentage;
  final double savingsPercentage;

  const EnvelopeBreakdown({
    required this.needsPaise,
    required this.wantsPaise,
    required this.savingsPaise,
    required this.totalSpentPaise,
    required this.needsPercentage,
    required this.wantsPercentage,
    required this.savingsPercentage,
  });
}

class ChaiFactorInsight {
  final int totalCount;
  final int totalPaise;
  final double percentageOfTotalSpend;
  final int averageSpendPaise;

  const ChaiFactorInsight({
    required this.totalCount,
    required this.totalPaise,
    required this.percentageOfTotalSpend,
    required this.averageSpendPaise,
  });
}

class AnalyticsEngine {
  /// Computes the 50/30/20 breakdown of total spending
  static EnvelopeBreakdown computeEnvelopeBreakdown({
    required int needsPaise,
    required int wantsPaise,
    required int savingsPaise,
  }) {
    final total = needsPaise + wantsPaise + savingsPaise;
    if (total == 0) {
      return const EnvelopeBreakdown(
        needsPaise: 0,
        wantsPaise: 0,
        savingsPaise: 0,
        totalSpentPaise: 0,
        needsPercentage: 0.0,
        wantsPercentage: 0.0,
        savingsPercentage: 0.0,
      );
    }

    return EnvelopeBreakdown(
      needsPaise: needsPaise,
      wantsPaise: wantsPaise,
      savingsPaise: savingsPaise,
      totalSpentPaise: total,
      needsPercentage: (needsPaise / total) * 100.0,
      wantsPercentage: (wantsPaise / total) * 100.0,
      savingsPercentage: (savingsPaise / total) * 100.0,
    );
  }

  /// Calculates Chai Factor (micro frequent transactions e.g. < ₹100)
  static ChaiFactorInsight computeChaiFactor({
    required List<int> debitsPaise,
    int thresholdPaise = 10000, // ₹100
  }) {
    final microSpends = debitsPaise.where((amt) => amt < thresholdPaise).toList();
    final totalSpend = debitsPaise.fold<int>(0, (sum, val) => sum + val);

    if (microSpends.isEmpty || totalSpend == 0) {
      return const ChaiFactorInsight(
        totalCount: 0,
        totalPaise: 0,
        percentageOfTotalSpend: 0.0,
        averageSpendPaise: 0,
      );
    }

    final totalMicroPaise = microSpends.fold<int>(0, (sum, val) => sum + val);
    final count = microSpends.length;
    final avg = totalMicroPaise ~/ count;
    final pct = (totalMicroPaise / totalSpend) * 100.0;

    return ChaiFactorInsight(
      totalCount: count,
      totalPaise: totalMicroPaise,
      percentageOfTotalSpend: pct,
      averageSpendPaise: avg,
    );
  }

  /// Evaluates spending pace:
  /// Compares actual spend against linear expected burn rate.
  static PaceStatus evaluatePace({
    required int spentSoFarPaise,
    required int totalSpendableBudgetPaise,
    required int daysElapsed,
    required int totalCycleDays,
  }) {
    if (totalCycleDays <= 0 || totalSpendableBudgetPaise <= 0) {
      return PaceStatus.onPace;
    }

    final expectedDailyBurn = totalSpendableBudgetPaise / totalCycleDays;
    final expectedSpentByNow = expectedDailyBurn * daysElapsed;

    // ±10% margin is considered on pace
    final lowerBound = expectedSpentByNow * 0.90;
    final upperBound = expectedSpentByNow * 1.10;

    if (spentSoFarPaise < lowerBound) {
      return PaceStatus.underpace;
    } else if (spentSoFarPaise > upperBound) {
      return PaceStatus.overpace;
    } else {
      return PaceStatus.onPace;
    }
  }
}

