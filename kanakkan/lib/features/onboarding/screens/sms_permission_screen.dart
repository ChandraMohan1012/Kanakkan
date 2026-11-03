import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../sms/sms_bridge_service.dart';

class SmsPermissionScreen extends StatefulWidget {
  final SmsBridgeService smsBridge;
  final VoidCallback onPermissionGranted;

  const SmsPermissionScreen({
    super.key,
    required this.smsBridge,
    required this.onPermissionGranted,
  });

  @override
  State<SmsPermissionScreen> createState() => _SmsPermissionScreenState();
}

class _SmsPermissionScreenState extends State<SmsPermissionScreen> {
  bool _isRequesting = false;
  bool _isDenied = false;

  void _requestPermission() async {
    setState(() {
      _isRequesting = true;
      _isDenied = false;
    });

    final granted = await widget.smsBridge.requestPermissions();

    setState(() {
      _isRequesting = false;
      _isDenied = !granted;
    });

    if (granted) {
      widget.smsBridge.startRealtimeListener();
      await widget.smsBridge.scanInbox();
      widget.onPermissionGranted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // Shield Hero Illustration
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_unread_rounded,
                  size: 44,
                  color: AppColors.primaryContainer,
                ),
              ),
              const SizedBox(height: 28),

              // Title
              const Text(
                'SMS Reading Permission',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              const Text(
                'Kanakkan reads only official bank transactional messages on your device to automate your daily safe spending ledger.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              // Privacy Guarantees Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    _GuaranteeRow(
                      icon: Icons.lock_outline_rounded,
                      title: '100% On-Device Only',
                      subtitle: 'Zero data leaves your phone. No telemetry, no remote servers.',
                    ),
                    SizedBox(height: 12),
                    _GuaranteeRow(
                      icon: Icons.filter_alt_outlined,
                      title: 'Official Bank Senders Only',
                      subtitle: 'Personal chats, promotional SMS, and OTPs are completely ignored.',
                    ),
                    SizedBox(height: 12),
                    _GuaranteeRow(
                      icon: Icons.sync_disabled_rounded,
                      title: 'No Cloud Analytics',
                      subtitle: 'Your ledger stays inside an encrypted SQLite database.',
                    ),
                  ],
                ),
              ),

              if (_isDenied) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.error_outline_rounded, color: AppColors.error, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'SMS permission was denied. Please allow SMS permission in Android Settings to continue.',
                          style: TextStyle(fontSize: 12, color: AppColors.onErrorContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const Spacer(),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isRequesting ? null : _requestPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: _isRequesting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          'Grant SMS Permission',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: widget.onPermissionGranted,
                child: const Text(
                  'Continue without SMS (Manual Only)',
                  style: TextStyle(color: AppColors.outline, fontSize: 13),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuaranteeRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _GuaranteeRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primaryContainer),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.outline)),
            ],
          ),
        ),
      ],
    );
  }
}

