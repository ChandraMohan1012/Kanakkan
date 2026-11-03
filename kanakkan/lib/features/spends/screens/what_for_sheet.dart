import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../data/local/app_database.dart';
import '../../../data/local/daos/transaction_dao.dart';

class WhatForSheet extends StatefulWidget {
  final Transaction transaction;
  final AppDatabase db;
  final TransactionDao transactionDao;

  const WhatForSheet({
    super.key,
    required this.transaction,
    required this.db,
    required this.transactionDao,
  });

  static Future<void> show(
    BuildContext context, {
    required Transaction transaction,
    required AppDatabase db,
    required TransactionDao transactionDao,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => WhatForSheet(
        transaction: transaction,
        db: db,
        transactionDao: transactionDao,
      ),
    );
  }

  @override
  State<WhatForSheet> createState() => _WhatForSheetState();
}

class _WhatForSheetState extends State<WhatForSheet> {
  late String _classification; // 'need' or 'want'
  String _p2pPurpose = 'spend'; // 'spend', 'lent', 'repaid', 'shared'
  String? _selectedCategoryId;
  bool _rememberPayee = true;

  @override
  void initState() {
    super.initState();
    _classification = widget.transaction.classification;
    _selectedCategoryId = widget.transaction.categoryId ?? 'cat_dining';
  }

  @override
  Widget build(BuildContext context) {
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
          // Drag Handle
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
                'What was this for?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, size: 20),
                color: AppColors.outline,
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Spend Context Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.store_rounded,
                    color: AppColors.primaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.transaction.payeeName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        'Amount: ${CurrencyUtils.formatPaise(widget.transaction.amountPaise)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Need vs Want Selector
          const Text(
            'CLASSIFICATION',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: AppColors.outline,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _ChoiceChip(
                  label: 'Need (Essential)',
                  isSelected: _classification == 'need',
                  activeColor: AppColors.primaryContainer,
                  onTap: () => setState(() => _classification = 'need'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ChoiceChip(
                  label: 'Want (Comfort)',
                  isSelected: _classification == 'want',
                  activeColor: AppColors.tertiary,
                  onTap: () => setState(() => _classification = 'want'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Purpose (If payment to person)
          const Text(
            'PURPOSE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: AppColors.outline,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final purpose in ['spend', 'lent', 'repaid', 'shared']) ...[
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _p2pPurpose = purpose),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: _p2pPurpose == purpose
                            ? AppColors.secondaryContainer
                            : AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        purpose[0].toUpperCase() + purpose.substring(1),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: _p2pPurpose == purpose
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _p2pPurpose == purpose
                              ? AppColors.onSecondaryContainer
                              : AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Categories Stream
          const Text(
            'SELECT CATEGORY',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: AppColors.outline,
            ),
          ),
          const SizedBox(height: 8),
          FutureBuilder<List<Category>>(
            future: widget.db.select(widget.db.categories).get(),
            builder: (context, snapshot) {
              final categories = snapshot.data ?? [];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((cat) {
                  final isSelected = cat.id == _selectedCategoryId;
                  return FilterChip(
                    label: Text(cat.name),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() {
                        _selectedCategoryId = cat.id;
                        _classification = cat.budgetType;
                      });
                    },
                    selectedColor: AppColors.secondaryContainer,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? AppColors.onSecondaryContainer
                          : AppColors.onSurfaceVariant,
                    ),
                    backgroundColor: AppColors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primaryContainer.withValues(alpha: 0.3)
                            : Colors.transparent,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 14),

          // Remember Payee Switch
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _rememberPayee,
            onChanged: (val) => setState(() => _rememberPayee = val ?? true),
            title: const Text(
              'Remember rule for this payee',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            subtitle: const Text(
              'Future transactions will be tagged silently.',
              style: TextStyle(fontSize: 11, color: AppColors.outline),
            ),
            activeColor: AppColors.primaryContainer,
          ),
          const SizedBox(height: 16),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                // Update transaction in database
                await widget.transactionDao.updateTransactionTag(
                  transactionId: widget.transaction.id,
                  categoryId: _selectedCategoryId,
                  classification: _classification,
                  tagStatus: 'confirmed',
                );

                if (_rememberPayee) {
                  final payeeClean = widget.transaction.payeeName
                      .trim()
                      .toLowerCase();
                  final payeeId = 'payee_${payeeClean.replaceAll(' ', '_')}';
                  await widget.db
                      .into(widget.db.payees)
                      .insertOnConflictUpdate(
                        PayeesCompanion(
                          id: drift.Value(payeeId),
                          name: drift.Value(widget.transaction.payeeName),
                          cleanedName: drift.Value(payeeClean),
                          keywordPatterns: drift.Value('["$payeeClean"]'),
                          defaultCategoryId: drift.Value(_selectedCategoryId),
                          defaultClassification: drift.Value(_classification),
                          p2pPurpose: drift.Value(_p2pPurpose),
                        ),
                      );
                }

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Save Tag',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  const _ChoiceChip({
    required this.label,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: 0.12)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? activeColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? activeColor : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
