import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'data/local/app_database.dart';
import 'data/local/daos/bank_dao.dart';
import 'data/local/daos/transaction_dao.dart';
import 'data/local/database_seeder.dart';
import 'features/shell/app_shell.dart';
import 'sms/parser.dart';
import 'sms/sms_bridge_service.dart';
import 'sms/unreadable_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Sovereign Local SQLite Database
  final db = AppDatabase();
  final bankDao = BankDao(db);
  final transactionDao = TransactionDao(db);
  final seeder = DatabaseSeeder(db);
  final unreadableStore = UnreadableStore();

  // Seed default Canara Bank templates, categories, and settings
  await seeder.seedInitialData();

  // Load active templates into Master SMS Parser
  final activeTemplates = await bankDao.getActiveTemplates();
  final smsParser = SmsParser(activeTemplates: activeTemplates);

  // Initialize Native SMS Bridge
  final smsBridge = SmsBridgeService(
    parser: smsParser,
    db: db,
    bankDao: bankDao,
    transactionDao: transactionDao,
    unreadableStore: unreadableStore,
  );

  // Check & request permissions, then listen for incoming real-time SMS
  final hasPermission = await smsBridge.checkPermissions();
  if (hasPermission) {
    smsBridge.startRealtimeListener();
    // Rescan inbox for missed messages while app was closed
    await smsBridge.scanInbox();
  }

  runApp(
    KanakkanApp(
      db: db,
      bankDao: bankDao,
      transactionDao: transactionDao,
      smsBridge: smsBridge,
      unreadableStore: unreadableStore,
    ),
  );
}

class KanakkanApp extends StatelessWidget {
  final AppDatabase db;
  final BankDao bankDao;
  final TransactionDao transactionDao;
  final SmsBridgeService smsBridge;
  final UnreadableStore unreadableStore;

  const KanakkanApp({
    super.key,
    required this.db,
    required this.bankDao,
    required this.transactionDao,
    required this.smsBridge,
    required this.unreadableStore,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanakkan',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: AppShell(
        db: db,
        bankDao: bankDao,
        transactionDao: transactionDao,
        unreadableStore: unreadableStore,
      ),
    );
  }
}
