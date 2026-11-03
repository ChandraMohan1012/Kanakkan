import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../data/local/app_database.dart';

class WhoIsThisSheet extends StatefulWidget {
  final AppDatabase db;
  final int amountPaise;
  final String accountDigits;
  final VoidCallback onClassified;

  const WhoIsThisSheet({
    super.key,
    required this.db,
    required this.amountPaise,
    required this.accountDigits,
    required this.onClassified,
  });

  static Future<void> show(
    BuildContext context, {
    required AppDatabase db,
    required int amountPaise,
    required String accountDigits,
    required VoidCallback onClassified,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => WhoIsThisSheet(
        db: db,
        amountPaise: amountPaise,
        accountDigits: accountDigits,
        onClassified: onClassified,
      ),
    );
  }

  @override
  State<WhoIsThisSheet> createState() => _WhoIsThisSheetState();
}

class _WhoIsThisSheetState extends State<WhoIsThisSheet> {
  String _selectedCategory = 'Friend';
  bool _rememberAccount = true;

  final _categories = ['Salary', 'Family', 'Friend', 'Repayment', 'Refund', 'Other'];

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
                'Who sent this money?',
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

          // Inbound Credit Context Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_downward_rounded, color: AppColors.primaryContainer, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CurrencyUtils.formatPaise(widget.amountPaise),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primaryContainer),
                    ),
                    Text(
                      'Credited from A/c ••${widget.accountDigits}',
                      style: const TextStyle(fontSize: 12, color: AppColors.outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Zero-assumption income notice
          const Text(
            'Received money is not counted as salary income unless explicitly marked as Salary.',
            style: TextStyle(fontSize: 12, color: AppColors.outline, height: 1.3),
          ),
          const SizedBox(height: 16),

          // Category Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((cat) {
              final isSelected = _selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: isSelected,
                selectedColor: AppColors.secondaryContainer,
                labelStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppColors.onSecondaryContainer : AppColors.onSurfaceVariant,
                ),
                onSelected: (_) => setState(() => _selectedCategory = cat),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          // Remember Account Switch
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _rememberAccount,
            onChanged: (val) => setState(() => _rememberAccount = val ?? true),
            title: const Text('Remember this sending account', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            subtitle: Text('Future credits from ••${widget.accountDigits} will be auto-labeled.', style: const TextStyle(fontSize: 11, color: AppColors.outline)),
            activeColor: AppColors.primaryContainer,
          ),
          const SizedBox(height: 16),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                widget.onClassified();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text('Save Classification', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

