import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../core/widgets/spend_tile.dart';
import '../../../data/local/app_database.dart';
import '../../../data/local/daos/transaction_dao.dart';
import 'what_for_sheet.dart';

class SpendsScreen extends StatefulWidget {
  final AppDatabase db;
  final TransactionDao transactionDao;

  const SpendsScreen({
    super.key,
    required this.db,
    required this.transactionDao,
  });

  @override
  State<SpendsScreen> createState() => _SpendsScreenState();
}

class _SpendsScreenState extends State<SpendsScreen> {
  String _activeFilter = 'All'; // 'All', 'Needs', 'Wants', 'Untagged'

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Transaction>>(
      stream: widget.transactionDao.watchRecentTransactions(limit: 100),
      builder: (context, snapshot) {
        final allTransactions = snapshot.data ?? [];

        int totalSpentPaise = 0;
        int needsPaise = 0;
        int wantsPaise = 0;
        int untaggedCount = 0;

        for (final t in allTransactions) {
          totalSpentPaise += t.amountPaise;
          if (t.tagStatus == 'untagged') {
            untaggedCount++;
          }
          if (t.classification.toLowerCase() == 'want') {
            wantsPaise += t.amountPaise;
          } else {
            needsPaise += t.amountPaise;
          }
        }

        final filtered = allTransactions.where((t) {
          if (_activeFilter == 'Needs') {
            return t.classification.toLowerCase() == 'need';
          }
          if (_activeFilter == 'Wants') {
            return t.classification.toLowerCase() == 'want';
          }
          if (_activeFilter == 'Untagged') {
            return t.tagStatus == 'untagged';
          }
          return true;
        }).toList();

        final needsRatio = totalSpentPaise > 0
            ? needsPaise / totalSpentPaise
            : 0.67;

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Month Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      'November 2026',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Icon(
                      Icons.expand_more_rounded,
                      size: 20,
                      color: AppColors.outline,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.tune_rounded,
                    color: AppColors.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Total Spent This Month Summary Card
            Container(
              padding: const EdgeInsets.all(16),
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
                        'TOTAL SPENT THIS CYCLE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppColors.outline,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 12,
                            color: AppColors.primaryContainer,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '27 days left',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    CurrencyUtils.formatPaise(
                      totalSpentPaise > 0 ? totalSpentPaise : 1260000,
                    ),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Needs vs Wants Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      height: 8,
                      child: Row(
                        children: [
                          Expanded(
                            flex: (needsRatio * 100).toInt(),
                            child: Container(color: AppColors.primaryContainer),
                          ),
                          Expanded(
                            flex: ((1.0 - needsRatio) * 100).toInt(),
                            child: Container(color: AppColors.tertiaryFixed),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Needs vs Wants Labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const Text(
                            'Needs ',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.outline,
                            ),
                          ),
                          Text(
                            CurrencyUtils.formatPaise(
                              needsPaise > 0 ? needsPaise : 840000,
                            ),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.tertiaryFixed,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Wants ',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.outline,
                            ),
                          ),
                          Text(
                            CurrencyUtils.formatPaise(
                              wantsPaise > 0 ? wantsPaise : 420000,
                            ),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Filter Chips Bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All (${allTransactions.length})',
                    isSelected: _activeFilter == 'All',
                    onTap: () => setState(() => _activeFilter = 'All'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Needs',
                    isSelected: _activeFilter == 'Needs',
                    onTap: () => setState(() => _activeFilter = 'Needs'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Wants',
                    isSelected: _activeFilter == 'Wants',
                    onTap: () => setState(() => _activeFilter = 'Wants'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Untagged',
                    badgeCount: untaggedCount > 0 ? untaggedCount : null,
                    isSelected: _activeFilter == 'Untagged',
                    onTap: () => setState(() => _activeFilter = 'Untagged'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Spends List
            if (filtered.isEmpty) ...[
              // Placeholder mock items if no data in DB yet
              const Text(
                'TODAY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(height: 8),
              SpendTile(
                title: 'Chai & Samosa',
                subtitle: 'Sharma Tea Stall • 4:15 PM',
                amountPaise: 4000,
                classification: 'want',
                tagStatus: 'confirmed',
                onTap: () {},
              ),
              const SizedBox(height: 8),
              SpendTile(
                title: 'Groceries & Milk',
                subtitle: 'Blinkit • 10:30 AM',
                amountPaise: 142000,
                classification: 'need',
                tagStatus: 'confirmed',
                onTap: () {},
              ),
              const SizedBox(height: 8),
              SpendTile(
                title: 'Metro Card Recharge',
                subtitle: 'DMRC • 8:45 AM',
                amountPaise: 50000,
                classification: 'need',
                tagStatus: 'confirmed',
                onTap: () {},
              ),
            ] else ...[
              for (final t in filtered) ...[
                SpendTile(
                  title: t.payeeName,
                  subtitle:
                      '${t.timestamp.day}/${t.timestamp.month} • ${t.tagStatus}',
                  amountPaise: t.amountPaise,
                  classification: t.classification,
                  tagStatus: t.tagStatus,
                  onTap: () {
                    if (t.tagStatus == 'untagged') {
                      WhatForSheet.show(
                        context,
                        transaction: t,
                        db: widget.db,
                        transactionDao: widget.transactionDao,
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
              ],
            ],
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int? badgeCount;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    this.badgeCount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
              ),
            ),
            if (badgeCount != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : AppColors.errorContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$badgeCount',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? AppColors.primaryContainer
                        : AppColors.error,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
