import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/currency_utils.dart';

class UnaccountedAlertBanner extends StatelessWidget {
  final int unaccountedPaise;
  final VoidCallback? onResolveTap;

  const UnaccountedAlertBanner({
    super.key,
    required this.unaccountedPaise,
    this.onResolveTap,
  });

  @override
  Widget build(BuildContext context) {
    if (unaccountedPaise == 0) return const SizedBox.shrink();

    final isMissingSpend = unaccountedPaise > 0;
    final formatted = CurrencyUtils.formatPaise(unaccountedPaise.abs());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.errorContainer.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$formatted unaccounted for',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onErrorContainer,
                  ),
                ),
                Text(
                  isMissingSpend
                      ? 'Bank balance dropped without an SMS. Add cash spend?'
                      : 'Bank balance is higher than tracked.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.onErrorContainer.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          if (onResolveTap != null)
            TextButton(
              onPressed: onResolveTap,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Resolve',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
