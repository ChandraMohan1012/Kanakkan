import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/currency_utils.dart';

class PaceHeroCard extends StatelessWidget {
  final int availableBalancePaise;
  final int dailySafePaise;
  final int spentPaise;
  final int totalIncomePaise;
  final int daysLeft;
  final String
  accountSubtitle; // e.g. "Credited ₹45,000 on 1 Nov • Canara Bank ••1234"

  const PaceHeroCard({
    super.key,
    required this.availableBalancePaise,
    required this.dailySafePaise,
    required this.spentPaise,
    required this.totalIncomePaise,
    required this.daysLeft,
    required this.accountSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTotal = totalIncomePaise > 0
        ? totalIncomePaise
        : (availableBalancePaise + spentPaise);
    final spentRatio = effectiveTotal > 0
        ? (spentPaise / effectiveTotal).clamp(0.0, 1.0)
        : 0.0;
    final spentPct = (spentRatio * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Available balance label + Account chip
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Available Balance',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        size: 13,
                        color: AppColors.primaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          accountSubtitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Main Balance Figure
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                CurrencyUtils.formatPaise(availableBalancePaise),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                  color: AppColors.primaryContainer,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'remaining',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Supportive Affirmation Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.spa_rounded,
                  size: 18,
                  color: AppColors.primaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.onSurface,
                        height: 1.3,
                      ),
                      children: [
                        const TextSpan(
                          text: "You're paced comfortably this cycle. ",
                        ),
                        TextSpan(
                          text: '${CurrencyUtils.formatPaise(dailySafePaise)} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                        const TextSpan(text: 'safe to spend per day.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Progress Allocation Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spent: ${CurrencyUtils.formatPaise(spentPaise)} ($spentPct%)',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                'Safe left: ${CurrencyUtils.formatPaise(availableBalancePaise)}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                value: spentRatio,
                backgroundColor: AppColors.secondaryContainer.withValues(
                  alpha: 0.5,
                ),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
