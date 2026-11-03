import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kanakkan_app_bar.dart';
import '../../../data/local/app_database.dart';
import '../../../data/local/daos/bank_dao.dart';
import '../../../sms/unreadable_store.dart';
import 'banks_and_accounts_screen.dart';
import 'categories_payee_rules_screen.dart';
import 'notifications_quiet_hours_screen.dart';
import 'salary_sources_screen.dart';
import 'template_builder_screen.dart';
import 'unreadable_messages_screen.dart';

class ProfileSettingsScreen extends StatelessWidget {
  final AppDatabase db;
  final BankDao bankDao;
  final UnreadableStore unreadableStore;

  const ProfileSettingsScreen({
    super.key,
    required this.db,
    required this.bankDao,
    required this.unreadableStore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KanakkanAppBar(
        title: 'Settings',
        showProfile: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Profile User Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryContainer.withOpacity(0.2), width: 1.5),
                  ),
                  child: const Icon(Icons.person_rounded, size: 28, color: AppColors.onSecondaryContainer),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Chandru', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.shield_rounded, size: 14, color: AppColors.primaryContainer),
                        SizedBox(width: 4),
                        Text('Sovereign Local Mode', style: TextStyle(fontSize: 12, color: AppColors.primaryContainer, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Section 1: Financial Architecture
          const Text('FINANCIAL ARCHITECTURE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.outline)),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.account_balance_rounded,
            title: 'Banks & Accounts',
            subtitle: 'Manage linked accounts, nicknames, own-account flags',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BanksAndAccountsScreen(db: db, bankDao: bankDao)),
            ),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.build_rounded,
            title: 'Bank Template Builder',
            subtitle: 'Teach the app new SMS formats by tapping words',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TemplateBuilderScreen(db: db, bankDao: bankDao)),
            ),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.work_outline_rounded,
            title: 'Salary Sources',
            subtitle: 'Configure multi-employer sources and auto-detection',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SalarySourcesScreen(db: db)),
            ),
          ),
          const SizedBox(height: 20),

          // Section 2: Preferences & Rules
          const Text('PREFERENCES & RULES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.outline)),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.category_rounded,
            title: 'Categories & Payee Rules',
            subtitle: '50/30/20 envelopes and learned merchant rules',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CategoriesPayeeRulesScreen(db: db)),
            ),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications & Quiet Hours',
            subtitle: 'Quiet hours, 1-min delay, and evening summary digest',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NotificationsQuietHoursScreen(db: db)),
            ),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.mark_email_unread_rounded,
            title: 'Unreadable Messages Quarantine',
            subtitle: 'Review unrecognized SMS and teach the parser',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UnreadableMessagesScreen(db: db, bankDao: bankDao, unreadableStore: unreadableStore)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: AppColors.primaryContainer),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.outline), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.outline),
          ],
        ),
      ),
    );
  }
}

