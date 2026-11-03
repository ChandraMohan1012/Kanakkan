import 'package:flutter/material.dart';
import '../../core/widgets/kanakkan_app_bar.dart';
import '../../core/widgets/kanakkan_bottom_nav.dart';
import '../../data/local/app_database.dart';
import '../../data/local/daos/bank_dao.dart';
import '../../data/local/daos/transaction_dao.dart';
import '../../sms/unreadable_store.dart';
import '../analytics/screens/analytics_screen.dart';
import '../goals/screens/goals_screen.dart';
import '../home/screens/home_dashboard_screen.dart';
import '../recurring/screens/recurring_screen.dart';
import '../settings/screens/profile_settings_screen.dart';
import '../spends/screens/manual_cash_spend_sheet.dart';
import '../spends/screens/spends_screen.dart';

class AppShell extends StatefulWidget {
  final AppDatabase db;
  final BankDao bankDao;
  final TransactionDao transactionDao;
  final UnreadableStore unreadableStore;

  const AppShell({
    super.key,
    required this.db,
    required this.bankDao,
    required this.transactionDao,
    required this.unreadableStore,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeDashboardScreen(
        db: widget.db,
        bankDao: widget.bankDao,
        transactionDao: widget.transactionDao,
        onNavigateToSpends: () => _onTabTapped(1),
        onNavigateToRecurring: () => _onTabTapped(2),
        onAddSpendTap: () => ManualCashSpendSheet.show(
          context,
          db: widget.db,
          transactionDao: widget.transactionDao,
        ),
      ),
      SpendsScreen(
        db: widget.db,
        transactionDao: widget.transactionDao,
      ),
      RecurringScreen(
        db: widget.db,
      ),
      AnalyticsScreen(
        db: widget.db,
      ),
      GoalsScreen(
        db: widget.db,
      ),
    ];

    final pageTitles = ['Kanakkan', 'Spends', 'Recurring', 'Analytics', 'Goals'];

    return Scaffold(
      appBar: KanakkanAppBar(
        title: pageTitles[_currentIndex],
        onProfileTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProfileSettingsScreen(
                db: widget.db,
                bankDao: widget.bankDao,
                unreadableStore: widget.unreadableStore,
              ),
            ),
          );
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: KanakkanBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
