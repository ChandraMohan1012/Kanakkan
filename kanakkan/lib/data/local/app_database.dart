import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/app_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Banks,
  BankTemplatesTable,
  Accounts,
  SalarySources,
  Cycles,
  Categories,
  Payees,
  Transactions,
  RecurringRules,
  Goals,
  Notes,
  NudgeLogs,
  UserSettings,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'kanakkan.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
