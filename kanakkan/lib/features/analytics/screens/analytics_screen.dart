import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../data/local/app_database.dart';

class AnalyticsScreen extends StatelessWidget {
  final AppDatabase db;

  const AnalyticsScreen({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Header
        const Text(
          'Spending Analytics',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '50/30/20 budget envelope and velocity tracking.',
          style: TextStyle(fontSize: 13, color: AppColors.outline),
        ),
        const SizedBox(height: 16),

        // Burn Velocity Pace Status Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'CYCLE BURN VELOCITY',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppColors.outline,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Comfortable Pace',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Day 3 of 30 • 10% elapsed',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.onSurface),
              ),
              const SizedBox(height: 6),
              const Text(
                'You have spent 28% of your discretionary budget. At this rate, your buffer will remain intact.',
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, height: 1.3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 50/30/20 Rule Envelopes
        const Text(
          '50 / 30 / 20 ENVELOPES',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.outline,
          ),
        ),
        const SizedBox(height: 10),

        // Needs Envelope
        _EnvelopeCard(
          title: 'Needs (Essentials)',
          targetPercentage: '50% (₹22,500)',
          actualSpentPaise: 1420000,
          actualPercentage: 58.0,
          progressColor: AppColors.primaryContainer,
          icon: Icons.home_rounded,
        ),
        const SizedBox(height: 10),

        // Wants Envelope
        _EnvelopeCard(
          title: 'Wants (Comfort & Treats)',
          targetPercentage: '30% (₹13,500)',
          actualSpentPaise: 580000,
          actualPercentage: 24.0,
          progressColor: AppColors.tertiary,
          icon: Icons.local_cafe_rounded,
        ),
        const SizedBox(height: 10),

        // Savings Envelope
        _EnvelopeCard(
          title: 'Savings & Goals',
          targetPercentage: '20% (₹9,000)',
          actualSpentPaise: 450000,
          actualPercentage: 18.0,
          progressColor: AppColors.secondary,
          icon: Icons.savings_rounded,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _EnvelopeCard extends StatelessWidget {
  final String title;
  final String targetPercentage;
  final int actualSpentPaise;
  final double actualPercentage;
  final Color progressColor;
  final IconData icon;

  const _EnvelopeCard({
    required this.title,
    required this.targetPercentage,
    required this.actualSpentPaise,
    required this.actualPercentage,
    required this.progressColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Row(
                children: [
                  Icon(icon, size: 18, color: progressColor),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              Text(
                'Target: $targetPercentage',
                style: const TextStyle(fontSize: 11, color: AppColors.outline),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                CurrencyUtils.formatPaise(actualSpentPaise),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                '${actualPercentage.toStringAsFixed(1)}% of total',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: progressColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: (actualPercentage / 100.0).clamp(0.0, 1.0),
                backgroundColor: AppColors.surfaceContainerHigh,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

