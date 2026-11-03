import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../core/widgets/pace_hero_card.dart';
import '../../../core/widgets/spend_tile.dart';
import '../../../core/widgets/unaccounted_alert_banner.dart';
import '../../../data/local/app_database.dart';
import '../../../data/local/daos/bank_dao.dart';
import '../../../data/local/daos/transaction_dao.dart';
import '../../../logic/cycle/cycle_calculator.dart';

class HomeDashboardScreen extends StatefulWidget {
  final AppDatabase db;
  final BankDao bankDao;
  final TransactionDao transactionDao;
  final VoidCallback onNavigateToSpends;
  final VoidCallback onNavigateToRecurring;
  final VoidCallback onAddSpendTap;

  const HomeDashboardScreen({
    super.key,
    required this.db,
    required this.bankDao,
    required this.transactionDao,
    required this.onNavigateToSpends,
    required this.onNavigateToRecurring,
    required this.onAddSpendTap,
  });

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Transaction>>(
      stream: widget.transactionDao.watchRecentTransactions(limit: 20),
      builder: (context, snapshot) {
        final transactions = snapshot.data ?? [];

        return StreamBuilder<List<Account>>(
          stream: widget.bankDao.watchAllAccounts(),
          builder: (context, accountSnapshot) {
            final accounts = accountSnapshot.data ?? [];
            final primaryAccount = accounts.isNotEmpty ? accounts.first : null;

            final availableBalance =
                primaryAccount?.runningBalancePaise ?? 3240000;
            final bankName = primaryAccount?.bankName ?? 'Bank';
            final last4 = primaryAccount?.last4Digits ?? '1234';

            // Calculate spent in needs vs wants
            int needsSpent = 0;
            int wantsSpent = 0;
            for (final t in transactions) {
              if (t.classification.toLowerCase() == 'want') {
                wantsSpent += t.amountPaise;
              } else {
                needsSpent += t.amountPaise;
              }
            }

            final totalSpent = needsSpent + wantsSpent;
            final paceResult = CycleCalculator.calculateDailyPace(
              availableBalancePaise: availableBalance,
              billsDueBeforeSalaryPaise: 0,
              bufferPaise: 200000,
              expectedSalaryDate: DateTime.now().add(const Duration(days: 27)),
            );

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                // Greeting & Cycle Status Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Cycle: ${paceResult.daysLeft} days left',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Good afternoon 👋',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer.withValues(
                          alpha: 0.4,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.wb_sunny_rounded,
                        color: AppColors.primaryContainer,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Unaccounted Balance Alert (if any)
                UnaccountedAlertBanner(
                  unaccountedPaise: 0,
                  onResolveTap: () {},
                ),

                // Primary Financial Pace Hero Card
                PaceHeroCard(
                  availableBalancePaise: availableBalance,
                  dailySafePaise: paceResult.dailySafePaise > 0
                      ? paceResult.dailySafePaise
                      : 120000,
                  spentPaise: totalSpent > 0 ? totalSpent : 1260000,
                  totalIncomePaise: 4500000,
                  daysLeft: paceResult.daysLeft,
                  accountSubtitle: '$bankName ••$last4',
                ),
                const SizedBox(height: 14),

                // Needs vs Wants Mini Cards
                Row(
                  children: [
                    // Needs Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'NEEDS',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.home_rounded,
                                    size: 14,
                                    color: AppColors.primaryContainer,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              CurrencyUtils.formatPaise(
                                needsSpent > 0 ? needsSpent : 840000,
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Rent, Groceries, WiFi',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Wants Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'WANTS',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    color: AppColors.tertiaryFixed,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.local_cafe_rounded,
                                    size: 14,
                                    color: AppColors.tertiary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              CurrencyUtils.formatPaise(
                                wantsSpent > 0 ? wantsSpent : 420000,
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Dining, Swiggy, Treats',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Quick Action Triggers
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: widget.onAddSpendTap,
                        icon: const Icon(Icons.add_rounded, size: 20),
                        label: const Text('Add Spend'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryContainer,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: widget.onNavigateToRecurring,
                        icon: const Icon(Icons.repeat_rounded, size: 18),
                        label: const Text('Recurring'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.onSurface,
                          side: const BorderSide(
                            color: AppColors.surfaceContainerHigh,
                          ),
                          backgroundColor: AppColors.surfaceContainerHigh
                              .withValues(alpha: 0.4),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Thoughtful Financial Care Banner
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lightbulb_rounded,
                          size: 18,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next Salary in ${paceResult.daysLeft} Days',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurface,
                              ),
                            ),
                            Text(
                              'SIPs auto-debited from $bankName ••$last4',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Recent Spends Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Spends',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    InkWell(
                      onTap: widget.onNavigateToSpends,
                      child: const Row(
                        children: [
                          Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryContainer,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
                            color: AppColors.primaryContainer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Recent Spends Feed
                if (transactions.isEmpty) ...[
                  // Seeded initial preview display if database has no entries yet
                  SpendTile(
                    title: 'Chai & Samosa',
                    subtitle: 'Sharma Tea Stall • Today, 4:15 PM',
                    amountPaise: 4000,
                    classification: 'want',
                    tagStatus: 'confirmed',
                    icon: Icons.coffee_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(height: 8),
                  SpendTile(
                    title: 'Groceries & Milk',
                    subtitle: "Nature's Basket • Yesterday",
                    amountPaise: 142000,
                    classification: 'need',
                    tagStatus: 'confirmed',
                    icon: Icons.shopping_cart_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(height: 8),
                  SpendTile(
                    title: 'Metro Card Recharge',
                    subtitle: 'DMRC / PayTM • 12 Oct',
                    amountPaise: 50000,
                    classification: 'need',
                    tagStatus: 'confirmed',
                    icon: Icons.train_rounded,
                    onTap: () {},
                  ),
                ] else ...[
                  for (final txn in transactions.take(5)) ...[
                    SpendTile(
                      title: txn.payeeName,
                      subtitle:
                          '$bankName ••$last4 • ${txn.timestamp.day}/${txn.timestamp.month}',
                      amountPaise: txn.amountPaise,
                      classification: txn.classification,
                      tagStatus: txn.tagStatus,
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
                const SizedBox(height: 24),
              ],
            );
          },
        );
      },
    );
  }
}
