import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class KanakkanAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showProfile;
  final VoidCallback? onProfileTap;
  final Widget? leading;
  final List<Widget>? actions;

  const KanakkanAppBar({
    super.key,
    this.title,
    this.showProfile = true,
    this.onProfileTap,
    this.leading,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface.withValues(alpha: 0.92),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (leading != null) ...[leading!, const SizedBox(width: 8)],
                  Text(
                    title ?? 'Kanakkan',
                    style: const TextStyle(
                      color: AppColors.primaryContainer,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ...?actions,
                  if (showProfile)
                    GestureDetector(
                      onTap: onProfileTap,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryContainer.withValues(
                              alpha: 0.2,
                            ),
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          size: 20,
                          color: AppColors.onSecondaryContainer,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
