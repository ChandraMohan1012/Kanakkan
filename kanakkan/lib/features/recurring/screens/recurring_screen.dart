import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../data/local/app_database.dart';

class RecurringScreen extends StatelessWidget {
  final AppDatabase db;

  const RecurringScreen({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Header
        const Text(
          'Recurring Commitments',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Bills and subscriptions detected automatically from cadence.',
          style: TextStyle(fontSize: 13, color: AppColors.outline),
        ),
        const SizedBox(height: 14),

        // Total Commitments Hero Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'MONTHLY COMMITTED',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppColors.outline,
                    ),
                  ),
                  Text(
                    '4 active bills',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                '₹14,200',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Reserved automatically from daily safe pace calculation.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Chai Factor Insight Card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.tertiaryFixed.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.tertiary.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.tertiaryFixed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_cafe_rounded,
                  color: AppColors.tertiary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequent Small Spends (Chai Factor)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onTertiaryFixedVariant,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '₹1,840 spent across 46 treats (< ₹100). Filtered out from bills and tracked as daily habits.',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.onTertiaryFixedVariant,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Fixed Subscriptions Section
        const Text(
          'FIXED SUBSCRIPTIONS (±10%)',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.outline,
          ),
        ),
        const SizedBox(height: 8),
        _BillItemTile(
          title: 'House Rent',
          cadence: 'Monthly on 1st',
          amountPaise: 1000000,
          status: 'Confirmed (3 sightings)',
          icon: Icons.home_rounded,
          isVariable: false,
        ),
        const SizedBox(height: 8),
        _BillItemTile(
          title: 'Mutual Fund SIP',
          cadence: 'Monthly on 5th',
          amountPaise: 350000,
          status: 'Confirmed (6 sightings)',
          icon: Icons.savings_rounded,
          isVariable: false,
        ),
        const SizedBox(height: 8),
        _BillItemTile(
          title: 'Netflix Subscription',
          cadence: 'Monthly on 14th',
          amountPaise: 64900,
          status: 'Confirmed (4 sightings)',
          icon: Icons.movie_rounded,
          isVariable: false,
        ),
        const SizedBox(height: 18),

        // Variable Bills Section
        const Text(
          'VARIABLE UTILITIES (±25%)',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.outline,
          ),
        ),
        const SizedBox(height: 8),
        _BillItemTile(
          title: 'Electricity (BESCOM)',
          cadence: 'Monthly ~12th • ±25%',
          amountPaise: 185000,
          status: 'Possible (2 sightings)',
          icon: Icons.bolt_rounded,
          isVariable: true,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _BillItemTile extends StatelessWidget {
  final String title;
  final String cadence;
  final int amountPaise;
  final String status;
  final IconData icon;
  final bool isVariable;

  const _BillItemTile({
    required this.title,
    required this.cadence,
    required this.amountPaise,
    required this.status,
    required this.icon,
    required this.isVariable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isVariable
                  ? AppColors.tertiaryFixed.withValues(alpha: 0.5)
                  : AppColors.secondaryContainer.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isVariable
                  ? AppColors.tertiary
                  : AppColors.primaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  cadence,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.outline,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyUtils.formatPaise(amountPaise),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                status,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isVariable
                      ? AppColors.tertiary
                      : AppColors.primaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
