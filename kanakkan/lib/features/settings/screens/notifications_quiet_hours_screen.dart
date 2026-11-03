import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kanakkan_app_bar.dart';
import '../../../data/local/app_database.dart';

class NotificationsQuietHoursScreen extends StatefulWidget {
  final AppDatabase db;

  const NotificationsQuietHoursScreen({super.key, required this.db});

  @override
  State<NotificationsQuietHoursScreen> createState() => _NotificationsQuietHoursScreenState();
}

class _NotificationsQuietHoursScreenState extends State<NotificationsQuietHoursScreen> {
  bool _quietHoursEnabled = true;
  final String _startTime = '22:00';
  final String _endTime = '08:00';
  bool _oneMinuteNudge = true;
  bool _eveningSummary = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KanakkanAppBar(
        title: 'Notifications & Quiet Hours',
        showProfile: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Quiet Hours Section
          Container(
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
                    const Row(
                      children: [
                        Icon(Icons.bedtime_rounded, color: AppColors.primaryContainer, size: 20),
                        SizedBox(width: 10),
                        Text('Quiet Hours', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Switch(
                      value: _quietHoursEnabled,
                      activeColor: AppColors.primaryContainer,
                      onChanged: (val) => setState(() => _quietHoursEnabled = val),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'No tagging notifications will sound during these hours. Spends will wait in your What For queue.',
                  style: TextStyle(fontSize: 12, color: AppColors.outline, height: 1.3),
                ),
                if (_quietHoursEnabled) ...[
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Start Time', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      TextButton(
                        onPressed: () {},
                        child: Text(_startTime, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryContainer)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('End Time', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      TextButton(
                        onPressed: () {},
                        child: Text(_endTime, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryContainer)),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tagging Nudge Rules Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TAGGING RULES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.outline)),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _oneMinuteNudge,
                  activeColor: AppColors.primaryContainer,
                  title: const Text('1-Minute Spend Delay', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  subtitle: const Text(
                    'Waits 60 seconds after a transaction before nudging, only for unknown payees.',
                    style: TextStyle(fontSize: 11, color: AppColors.outline),
                  ),
                  onChanged: (val) => setState(() => _oneMinuteNudge = val),
                ),
                const Divider(height: 16),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _eveningSummary,
                  activeColor: AppColors.primaryContainer,
                  title: const Text('Evening Summary Digest', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  subtitle: const Text(
                    'Sends a single combined reminder at 8 PM if you have untagged spends in your queue.',
                    style: TextStyle(fontSize: 11, color: AppColors.outline),
                  ),
                  onChanged: (val) => setState(() => _eveningSummary = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
