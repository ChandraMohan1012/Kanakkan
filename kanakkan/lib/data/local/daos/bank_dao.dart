import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:kanakkan/sms/template_model.dart';
import '../app_database.dart';

class BankDao {
  final AppDatabase db;

  BankDao(this.db);

  // --- Banks ---
  Future<List<Bank>> getAllBanks() => db.select(db.banks).get();
  Stream<List<Bank>> watchAllBanks() => db.select(db.banks).watch();

  Future<void> insertBank(BanksCompanion bank) =>
      db.into(db.banks).insertOnConflictUpdate(bank);

  // --- Templates ---
  Future<List<BankTemplate>> getActiveTemplates() async {
    final rows = await (db.select(db.bankTemplatesTable)
          ..where((tbl) => tbl.isActive.equals(true)))
        .get();

    return rows.map((r) {
      final senderList = (jsonDecode(r.senderIds) as List<dynamic>).cast<String>();
      final currencyList =
          (jsonDecode(r.currencyKeywords) as List<dynamic>).cast<String>();
      final tokenMap = (jsonDecode(r.tokenMap) as Map<String, dynamic>).cast<String, String>();

      final type = r.txnType == 'credit'
          ? TransactionType.credit
          : r.txnType == 'transfer'
              ? TransactionType.transfer
              : TransactionType.debit;

      return BankTemplate(
        id: r.id,
        bankName: r.bankName,
        senderIds: senderList,
        txnType: type,
        pattern: r.pattern,
        dateFormat: r.dateFormat,
        currencyKeywords: currencyList,
        tokenMap: tokenMap,
        version: r.version,
      );
    }).toList();
  }

  Future<void> insertTemplate(BankTemplate template, String bankId) {
    return db.into(db.bankTemplatesTable).insertOnConflictUpdate(
          BankTemplatesTableCompanion.insert(
            id: template.id,
            bankId: bankId,
            bankName: template.bankName,
            senderIds: jsonEncode(template.senderIds),
            txnType: template.txnType == TransactionType.credit ? 'credit' : 'debit',
            pattern: template.pattern,
            dateFormat: template.dateFormat,
            currencyKeywords: jsonEncode(template.currencyKeywords),
            tokenMap: jsonEncode(template.tokenMap),
            version: Value(template.version),
            isActive: const Value(true),
          ),
        );
  }

  // --- Accounts ---
  Future<List<Account>> getAllAccounts() => db.select(db.accounts).get();
  Stream<List<Account>> watchAllAccounts() =>
      (db.select(db.accounts)..where((tbl) => tbl.isArchived.equals(false))).watch();

  Future<Account?> getAccountByLast4(String last4) =>
      (db.select(db.accounts)..where((tbl) => tbl.last4Digits.equals(last4)))
          .getSingleOrNull();

  Future<Account?> getAccountById(String id) =>
      (db.select(db.accounts)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<void> upsertAccount(AccountsCompanion account) =>
      db.into(db.accounts).insertOnConflictUpdate(account);

  Future<void> updateAccountBalance(String accountId, int newBalancePaise) {
    return (db.update(db.accounts)..where((tbl) => tbl.id.equals(accountId))).write(
      AccountsCompanion(
        runningBalancePaise: Value(newBalancePaise),
      ),
    );
  }
}
