import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../data/local/app_database.dart';
import 'can_i_buy_sheet.dart';

class GoalsScreen extends StatelessWidget {
  final AppDatabase db;

  const GoalsScreen({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Header
        const Text(
          'Sinking Funds & Goals',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Target savings with real-time ETA derived from your monthly surplus.',
          style: TextStyle(fontSize: 13, color: AppColors.outline),
        ),
        const SizedBox(height: 16),

        // "Can I buy it now?" Interactive Trigger Banner
        InkWell(
          onTap: () => CanIBuySheet.show(context),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.primaryContainer.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Can I buy it now?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Test any purchase against your safe daily pace.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.primaryContainer,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Goals List Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ACTIVE GOALS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: AppColors.outline,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: AppColors.primaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Goal 1: Emergency Fund
        _GoalCard(
          title: '3-Month Emergency Fund',
          targetPaise: 10000000, // ₹1,00,000
          savedPaise: 3500000, // ₹35,000
          etaMonths: 4.3,
          icon: Icons.shield_rounded,
        ),
        const SizedBox(height: 12),

        // Goal 2: MacBook Pro
        _GoalCard(
          title: 'MacBook Pro Workstation',
          targetPaise: 15000000, // ₹1,50,000
          savedPaise: 4500000, // ₹45,000
          etaMonths: 7.0,
          icon: Icons.laptop_mac_rounded,
        ),
        const SizedBox(height: 12),

        // Goal 3: Annual Insurance Renewal
        _GoalCard(
          title: 'Annual Health Insurance',
          targetPaise: 2400000, // ₹24,000
          savedPaise: 1800000, // ₹18,000
          etaMonths: 0.8,
          icon: Icons.health_and_safety_rounded,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _GoalCard extends StatelessWidget {
  final String title;
  final int targetPaise;
  final int savedPaise;
  final double etaMonths;
  final IconData icon;

  const _GoalCard({
    required this.title,
    required this.targetPaise,
    required this.savedPaise,
    required this.etaMonths,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final progress = targetPaise > 0
        ? (savedPaise / targetPaise).clamp(0.0, 1.0)
        : 0.0;
    final pct = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primaryContainer, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'ETA: ~$etaMonths months at current surplus',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.outline,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$pct%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saved: ${CurrencyUtils.formatPaise(savedPaise)}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Target: ${CurrencyUtils.formatPaise(targetPaise)}',
                style: const TextStyle(fontSize: 12, color: AppColors.outline),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.surfaceContainerHigh,
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
