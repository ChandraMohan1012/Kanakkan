import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/app_database.dart';
import '../../../data/local/daos/transaction_dao.dart';
import '../../../sms/dedupe.dart';

class ManualCashSpendSheet extends StatefulWidget {
  final AppDatabase db;
  final TransactionDao transactionDao;
  final int? suggestedAmountPaise;

  const ManualCashSpendSheet({
    super.key,
    required this.db,
    required this.transactionDao,
    this.suggestedAmountPaise,
  });

  static Future<void> show(
    BuildContext context, {
    required AppDatabase db,
    required TransactionDao transactionDao,
    int? suggestedAmountPaise,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ManualCashSpendSheet(
        db: db,
        transactionDao: transactionDao,
        suggestedAmountPaise: suggestedAmountPaise,
      ),
    );
  }

  @override
  State<ManualCashSpendSheet> createState() => _ManualCashSpendSheetState();
}

class _ManualCashSpendSheetState extends State<ManualCashSpendSheet> {
  late TextEditingController _amountController;
  final _payeeController = TextEditingController();
  String _classification = 'need';
  final String _selectedCategoryId = 'cat_miscellaneous';

  @override
  void initState() {
    super.initState();
    final initRupees = widget.suggestedAmountPaise != null
        ? '${widget.suggestedAmountPaise! ~/ 100}'
        : '';
    _amountController = TextEditingController(text: initRupees);
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
                'Add Cash Spend',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.onSurface),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, size: 20),
                color: AppColors.outline,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Amount Input
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primaryContainer),
            decoration: InputDecoration(
              prefixText: '₹ ',
              prefixStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primaryContainer),
              labelText: 'Amount Spent',
              filled: true,
              fillColor: AppColors.surfaceContainerLow,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 14),

          // Payee / Note Input
          TextField(
            controller: _payeeController,
            decoration: InputDecoration(
              labelText: 'What did you buy? / Payee',
              hintText: 'e.g. Chai, Auto rickshaw, Vegetables',
              filled: true,
              fillColor: AppColors.surfaceContainerLow,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 14),

          // Need vs Want Selector
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('Need (Essential)')),
                  selected: _classification == 'need',
                  selectedColor: AppColors.secondaryContainer,
                  onSelected: (val) => setState(() => _classification = 'need'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('Want (Treat)')),
                  selected: _classification == 'want',
                  selectedColor: AppColors.tertiaryFixed,
                  onSelected: (val) => setState(() => _classification = 'want'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                final rupees = int.tryParse(_amountController.text.trim()) ?? 0;
                final payee = _payeeController.text.trim().isEmpty ? 'Cash Spend' : _payeeController.text.trim();
                if (rupees <= 0) return;

                final amountPaise = rupees * 100;
                final now = DateTime.now();
                final dedupeHash = DedupeEngine.computeFallbackKey(
                  amountPaise: amountPaise,
                  payee: payee,
                  date: now,
                );

                // Get primary account
                final accounts = await widget.db.select(widget.db.accounts).get();
                final accountId = accounts.isNotEmpty ? accounts.first.id : 'acc_cash';

                final txnId = 'txn_cash_${now.microsecondsSinceEpoch}';
                await widget.transactionDao.insertTransactionSafe(
                  TransactionsCompanion(
                    id: drift.Value(txnId),
                    accountId: drift.Value(accountId),
                    amountPaise: drift.Value(amountPaise),
                    txnType: const drift.Value('debit'),
                    classification: drift.Value(_classification),
                    categoryId: drift.Value(_selectedCategoryId),
                    payeeName: drift.Value(payee),
                    timestamp: drift.Value(now),
                    receivedAt: drift.Value(now),
                    rawSmsBody: const drift.Value('Manual cash entry'),
                    dedupeHash: drift.Value(dedupeHash),
                    tagStatus: const drift.Value('confirmed'),
                  ),
                );

                if (context.mounted) Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text('Record Cash Spend', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
