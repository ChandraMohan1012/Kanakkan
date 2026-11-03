enum CanIBuyStatus { yes, notYet }

class CanIBuyResult {
  final CanIBuyStatus status;
  final int purchasePricePaise;
  final int discretionaryFreeCashPaise;
  final int? shortfallPaise;
  final int? oldDailySafePaise;
  final int? newDailySafePaise;
  final int? daysToWait;
  final String explanation;

  const CanIBuyResult({
    required this.status,
    required this.purchasePricePaise,
    required this.discretionaryFreeCashPaise,
    this.shortfallPaise,
    this.oldDailySafePaise,
    this.newDailySafePaise,
    this.daysToWait,
    required this.explanation,
  });

  bool get isAffordable => status == CanIBuyStatus.yes;
}

class CanIBuyEngine {
  /// Evaluates purchase viability:
  /// Discretionary Free Cash = Available Balance - Bills Due - Buffer.
  /// If Purchase Price <= Discretionary Free Cash => YES.
  /// Else => NOT YET, with shortfall and suggested timeline.
  static CanIBuyResult evaluate({
    required int purchasePricePaise,
    required int availableBalancePaise,
    required int billsDueBeforeSalaryPaise,
    required int bufferPaise,
    required int daysUntilSalary,
    int? monthlySurplusPaise,
  }) {
    final effectiveDays = daysUntilSalary > 0 ? daysUntilSalary : 1;
    final discretionaryFreeCash =
        availableBalancePaise - billsDueBeforeSalaryPaise - bufferPaise;

    final oldDailySafe = discretionaryFreeCash > 0
        ? (discretionaryFreeCash ~/ effectiveDays)
        : 0;

    if (purchasePricePaise <= discretionaryFreeCash) {
      final remainingCash = discretionaryFreeCash - purchasePricePaise;
      final newDailySafe = remainingCash ~/ effectiveDays;

      return CanIBuyResult(
        status: CanIBuyStatus.yes,
        purchasePricePaise: purchasePricePaise,
        discretionaryFreeCashPaise: discretionaryFreeCash,
        oldDailySafePaise: oldDailySafe,
        newDailySafePaise: newDailySafe,
        explanation:
            'You can afford this. Daily safe spend will adjust from ₹${oldDailySafe ~/ 100} to ₹${newDailySafe ~/ 100} for the remaining $effectiveDays days.',
      );
    } else {
      final shortfall = purchasePricePaise - discretionaryFreeCash;

      int? waitDays;
      if (monthlySurplusPaise != null && monthlySurplusPaise > 0) {
        final dailySurplus = monthlySurplusPaise / 30.0;
        waitDays = (shortfall / dailySurplus).ceil();
      }

      return CanIBuyResult(
        status: CanIBuyStatus.notYet,
        purchasePricePaise: purchasePricePaise,
        discretionaryFreeCashPaise: discretionaryFreeCash,
        shortfallPaise: shortfall,
        daysToWait: waitDays,
        explanation: waitDays != null
            ? 'Not yet. You are short by ₹${shortfall ~/ 100}. At your current monthly surplus rate, you will reach this in ~$waitDays days.'
            : 'Not yet. You are short by ₹${shortfall ~/ 100} after accounting for buffer and upcoming bills.',
      );
    }
  }

  /// Sinking fund goal ETA calculation:
  /// Monthly Surplus = Salary - Recurring Payments - Avg Variable Spends.
  /// ETA in months = (Target Price - Saved) / Monthly Surplus.
  static double calculateGoalEtaMonths({
    required int targetPaise,
    required int savedPaise,
    required int monthlySurplusPaise,
  }) {
    final remainingPaise = targetPaise - savedPaise;
    if (remainingPaise <= 0) return 0.0;
    if (monthlySurplusPaise <= 0) return double.infinity;

    return remainingPaise / monthlySurplusPaise;
  }
}

