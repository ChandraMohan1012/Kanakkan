import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../data/local/app_database.dart';
import '../../../logic/cycle/cycle_calculator.dart';

class SalaryArrivalSheet extends StatelessWidget {
  final AppDatabase db;
  final int creditAmountPaise;
  final String senderAccount;
  final DateTime arrivalDate;
  final VoidCallback onCycleUpdated;

  const SalaryArrivalSheet({
    super.key,
    required this.db,
    required this.creditAmountPaise,
    required this.senderAccount,
    required this.arrivalDate,
    required this.onCycleUpdated,
  });

  static Future<void> show(
    BuildContext context, {
    required AppDatabase db,
    required int creditAmountPaise,
    required String senderAccount,
    required DateTime arrivalDate,
    required VoidCallback onCycleUpdated,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SalaryArrivalSheet(
        db: db,
        creditAmountPaise: creditAmountPaise,
        senderAccount: senderAccount,
        arrivalDate: arrivalDate,
        onCycleUpdated: onCycleUpdated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedAmount = CurrencyUtils.formatPaise(creditAmountPaise);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Salary Inbound Detected',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.onSurface),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, size: 20),
                color: AppColors.outline,
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Amount & Source highlight card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withOpacity(0.35),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryContainer.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.payments_rounded, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedAmount,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                    Text(
                      'Credited from $senderAccount',
                      style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'What would you like to do with this credit?',
            style: TextStyle(fontSize: 13, color: AppColors.outline),
          ),
          const SizedBox(height: 14),

          // Option 1: Start New Cycle
          _ActionCard(
            title: 'Start a new salary cycle',
            subtitle: 'Resets days left and starts a fresh daily safe-to-spend pace.',
            icon: Icons.refresh_rounded,
            isPrimary: true,
            onTap: () async {
              final nextDate = CycleCalculator.suggestNextSalaryDate(
                currentSalaryDate: arrivalDate,
              );

              final cycleId = 'cycle_${DateTime.now().millisecondsSinceEpoch}';
              await db.into(db.cycles).insert(
                    CyclesCompanion(
                      id: drift.Value(cycleId),
                      startDate: drift.Value(arrivalDate),
                      expectedNextDate: drift.Value(nextDate),
                      confirmedSalaryPaise: drift.Value(creditAmountPaise),
                      isActive: const drift.Value(true),
                    ),
                  );

              onCycleUpdated();
              if (context.mounted) Navigator.pop(context);
            },
          ),
          const SizedBox(height: 10),

          // Option 2: Add to Current Cycle
          _ActionCard(
            title: 'Add to current cycle',
            subtitle: 'Increases current spendable pool without resetting cycle dates.',
            icon: Icons.add_circle_outline_rounded,
            isPrimary: false,
            onTap: () {
              onCycleUpdated();
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 10),

          // Option 3: Not Salary
          _ActionCard(
            title: 'Not salary',
            subtitle: 'Treat as standard deposit, loan repayment, or external transfer.',
            icon: Icons.block_rounded,
            isPrimary: false,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.secondaryContainer.withOpacity(0.25) : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isPrimary ? AppColors.primaryContainer : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isPrimary ? AppColors.primaryContainer : AppColors.outline, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isPrimary ? AppColors.primaryContainer : AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: AppColors.outline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

