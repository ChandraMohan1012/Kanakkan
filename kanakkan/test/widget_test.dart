import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kanakkan/data/local/app_database.dart';
import 'package:kanakkan/data/local/daos/bank_dao.dart';
import 'package:kanakkan/data/local/daos/transaction_dao.dart';
import 'package:kanakkan/data/local/database_seeder.dart';
import 'package:kanakkan/main.dart';
import 'package:kanakkan/sms/parser.dart';
import 'package:kanakkan/sms/sms_bridge_service.dart';
import 'package:kanakkan/sms/unreadable_store.dart';

void main() {
  testWidgets('Kanakkan App Shell smoke test', (WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final bankDao = BankDao(db);
    final transactionDao = TransactionDao(db);
    final seeder = DatabaseSeeder(db);
    final unreadableStore = UnreadableStore();

    await seeder.seedInitialData();
    final templates = await bankDao.getActiveTemplates();
    final smsParser = SmsParser(activeTemplates: templates);

    final smsBridge = SmsBridgeService(
      parser: smsParser,
      db: db,
      bankDao: bankDao,
      transactionDao: transactionDao,
      unreadableStore: unreadableStore,
    );

    // Build the app
    await tester.pumpWidget(
      KanakkanApp(
        db: db,
        bankDao: bankDao,
        transactionDao: transactionDao,
        smsBridge: smsBridge,
        unreadableStore: unreadableStore,
      ),
    );
    await tester.pumpAndSettle();

    // Verify Kanakkan branding and home elements render
    expect(find.text('Kanakkan'), findsOneWidget);
    expect(find.text('Available Balance'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Spends'), findsOneWidget);
    expect(find.text('Recurring'), findsAtLeastNWidgets(1));
    expect(find.text('Analytics'), findsOneWidget);
    expect(find.text('Goals'), findsOneWidget);

    await db.close();
  });
}
