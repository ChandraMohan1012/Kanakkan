import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../logic/goals/can_i_buy_engine.dart';

class CanIBuySheet extends StatefulWidget {
  final int availableBalancePaise;
  final int committedBillsPaise;
  final int bufferPaise;
  final int daysUntilSalary;
  final int monthlySurplusPaise;

  const CanIBuySheet({
    super.key,
    required this.availableBalancePaise,
    required this.committedBillsPaise,
    required this.bufferPaise,
    required this.daysUntilSalary,
    required this.monthlySurplusPaise,
  });

  static Future<void> show(
    BuildContext context, {
    int availableBalancePaise = 3240000,
    int committedBillsPaise = 1000000,
    int bufferPaise = 200000,
    int daysUntilSalary = 27,
    int monthlySurplusPaise = 1500000,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CanIBuySheet(
        availableBalancePaise: availableBalancePaise,
        committedBillsPaise: committedBillsPaise,
        bufferPaise: bufferPaise,
        daysUntilSalary: daysUntilSalary,
        monthlySurplusPaise: monthlySurplusPaise,
      ),
    );
  }

  @override
  State<CanIBuySheet> createState() => _CanIBuySheetState();
}

class _CanIBuySheetState extends State<CanIBuySheet> {
  final TextEditingController _priceController = TextEditingController();
  CanIBuyResult? _result;

  void _calculate(String value) {
    final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.isEmpty) {
      setState(() => _result = null);
      return;
    }

    final rupees = int.tryParse(clean) ?? 0;
    final purchasePaise = rupees * 100;

    final eval = CanIBuyEngine.evaluate(
      purchasePricePaise: purchasePaise,
      availableBalancePaise: widget.availableBalancePaise,
      billsDueBeforeSalaryPaise: widget.committedBillsPaise,
      bufferPaise: widget.bufferPaise,
      daysUntilSalary: widget.daysUntilSalary,
      monthlySurplusPaise: widget.monthlySurplusPaise,
    );

    setState(() => _result = eval);
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
          // Drag handle
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
                'Can I buy it now?',
                style: TextStyle(
                  fontSize: 20,
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
          const Text(
            'Checks discretionary free cash after reserving bills and your ₹2,000 safety buffer.',
            style: TextStyle(fontSize: 12, color: AppColors.outline),
          ),
          const SizedBox(height: 18),

          // Price Input
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            autofocus: true,
            onChanged: _calculate,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryContainer,
            ),
            decoration: InputDecoration(
              prefixText: '₹ ',
              prefixStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryContainer,
              ),
              hintText: 'Enter purchase price',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.outline,
              ),
              filled: true,
              fillColor: AppColors.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Result Verdict Card
          if (_result != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _result!.isAffordable
                    ? AppColors.secondaryContainer.withValues(alpha: 0.35)
                    : AppColors.tertiaryFixed.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _result!.isAffordable
                      ? AppColors.primaryContainer.withValues(alpha: 0.3)
                      : AppColors.tertiary.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _result!.isAffordable
                            ? Icons.check_circle_rounded
                            : Icons.schedule_rounded,
                        color: _result!.isAffordable
                            ? AppColors.primaryContainer
                            : AppColors.tertiary,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _result!.isAffordable
                            ? 'Yes, you can buy this!'
                            : 'Not yet — Shortfall detected',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _result!.isAffordable
                              ? AppColors.primaryContainer
                              : AppColors.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _result!.explanation,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurface,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
