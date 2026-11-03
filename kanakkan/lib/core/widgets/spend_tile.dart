import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/currency_utils.dart';

class SpendTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int amountPaise;
  final String classification; // 'need', 'want'
  final String tagStatus; // 'confirmed', 'guessed', 'untagged'
  final IconData? icon;
  final VoidCallback? onTap;

  const SpendTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amountPaise,
    required this.classification,
    required this.tagStatus,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUntagged = tagStatus == 'untagged';
    final isWant = classification.toLowerCase() == 'want';

    final Color badgeBg;
    final Color badgeText;
    final String badgeLabel;

    if (isUntagged) {
      badgeBg = AppColors.errorContainer;
      badgeText = AppColors.error;
      badgeLabel = 'What for?';
    } else if (isWant) {
      badgeBg = AppColors.tertiaryFixed.withValues(alpha: 0.6);
      badgeText = AppColors.onTertiaryFixedVariant;
      badgeLabel = 'Wants';
    } else {
      badgeBg = AppColors.secondaryContainer.withValues(alpha: 0.6);
      badgeText = AppColors.onSecondaryContainer;
      badgeLabel = 'Needs';
    }

    final Color iconBg = isWant
        ? AppColors.tertiaryFixed
        : AppColors.secondaryContainer.withValues(alpha: 0.4);
    final Color iconColor = isWant
        ? AppColors.tertiary
        : AppColors.primaryContainer;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
        child: Row(
          children: [
            // Category Icon
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(
                icon ??
                    (isWant
                        ? Icons.local_cafe_rounded
                        : Icons.shopping_cart_rounded),
                size: 20,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 12),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Amount & Tag Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '-${CurrencyUtils.formatPaise(amountPaise)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badgeLabel,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: badgeText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
