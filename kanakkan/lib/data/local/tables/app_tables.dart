import 'package:drift/drift.dart';

/// 1. Banks Table
class Banks extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get primaryColor => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 2. BankTemplates Table (Dynamic Templates as Data)
class BankTemplatesTable extends Table {
  TextColumn get id => text()();
  TextColumn get bankId => text().references(Banks, #id)();
  TextColumn get bankName => text()();
  TextColumn get senderIds => text()(); // JSON List of sender strings
  TextColumn get txnType => text()(); // 'debit', 'credit', 'transfer'
  TextColumn get pattern => text()(); // Regex pattern string
  TextColumn get dateFormat => text()(); // e.g. 'dd/MM/yyyy'
  TextColumn get currencyKeywords => text()(); // JSON List of symbols
  TextColumn get tokenMap => text()(); // JSON Map of capture groups
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 3. Accounts Table (Decoupled from Banks)
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get bankId => text().nullable().references(Banks, #id)();
  TextColumn get bankName => text()();
  TextColumn get last4Digits => text()();
  TextColumn get nickname => text().nullable()();
  BoolColumn get isOwnAccount => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  IntColumn get runningBalancePaise => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 4. SalarySources Table (Multi-employer / flexible income streams)
class SalarySources extends Table {
  TextColumn get id => text()();
  TextColumn get label => text()();
  TextColumn get sendingAccountDigits => text().nullable()();
  TextColumn get linkedAccountId => text().nullable().references(Accounts, #id)();
  IntColumn get lastCreditedAmountPaise => integer().nullable()();
  DateTimeColumn get lastCreditedDate => dateTime().nullable()();
  BoolColumn get isPaused => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 5. Cycles Table (Dynamic Salary Cycles)
class Cycles extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get expectedNextDate => dateTime().nullable()();
  IntColumn get confirmedSalaryPaise => integer()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 6. Categories Table (50/30/20 default Envelopes)
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  TextColumn get budgetType => text()(); // 'need', 'want'
  IntColumn get monthlyLimitPaise => integer().nullable()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 7. Payees Table (Merchant keywords & auto-rules)
class Payees extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get cleanedName => text()();
  TextColumn get keywordPatterns => text()(); // JSON List of substrings
  TextColumn get defaultCategoryId => text().nullable().references(Categories, #id)();
  TextColumn get defaultClassification => text().nullable()(); // 'need', 'want'
  TextColumn get p2pPurpose => text().nullable()(); // 'lent', 'repaid', 'shared', 'spend'

  @override
  Set<Column> get primaryKey => {id};
}

/// 8. Transactions Table (Core Sovereign Ledger)
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text().references(Accounts, #id)();
  TextColumn get cycleId => text().nullable().references(Cycles, #id)();
  IntColumn get amountPaise => integer()();
  TextColumn get txnType => text()(); // 'debit', 'credit', 'transfer'
  TextColumn get classification => text().withDefault(const Constant('need'))(); // 'need', 'want'
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get payeeId => text().nullable().references(Payees, #id)();
  TextColumn get payeeName => text()();
  IntColumn get balanceAfterPaise => integer().nullable()();
  DateTimeColumn get timestamp => dateTime()();
  DateTimeColumn get receivedAt => dateTime()();
  TextColumn get rawSmsBody => text()();
  TextColumn get dedupeHash => text().unique()();
  TextColumn get upiRef => text().nullable()();
  BoolColumn get isFlagged => boolean().withDefault(const Constant(false))();
  TextColumn get flagReason => text().nullable()();
  TextColumn get tagStatus => text().withDefault(const Constant('untagged'))(); // 'confirmed', 'guessed', 'untagged'

  @override
  Set<Column> get primaryKey => {id};
}

/// 9. RecurringRules Table (Cadence detection & anomaly tracking)
class RecurringRules extends Table {
  TextColumn get id => text()();
  TextColumn get payeeId => text().references(Payees, #id)();
  TextColumn get accountId => text().references(Accounts, #id)();
  IntColumn get medianAmountPaise => integer()();
  TextColumn get toleranceType => text()(); // 'fixed_10%', 'variable_25%'
  IntColumn get cadenceDays => integer()(); // 7, 14, 30, 365
  TextColumn get status => text()(); // 'possible', 'confirmed', 'dismissed'
  IntColumn get dueDayOfMonth => integer().nullable()();
  DateTimeColumn get lastDebitedDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 10. Goals Table (Sinking funds & 'Can I buy it now?' engine)
class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get targetPaise => integer()();
  IntColumn get savedPaise => integer().withDefault(const Constant(0))();
  IntColumn get priorityOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  BoolColumn get isPaused => boolean().withDefault(const Constant(false))();
  DateTimeColumn get targetDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 11. Notes Table (Context attachments for future local RAG)
class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()(); // 'transaction', 'goal', 'cycle'
  TextColumn get entityId => text()();
  TextColumn get noteText => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 12. NudgeLogs Table (Daily nudge capping & coaching history)
class NudgeLogs extends Table {
  TextColumn get id => text()();
  TextColumn get nudgeType => text()();
  TextColumn get numbersPayloadJson => text()(); // Pre-computed numbers from deterministic code
  TextColumn get userAction => text().nullable()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// 13. UserSettings Table (Dynamic Config as Data)
class UserSettings extends Table {
  TextColumn get settingKey => text()();
  TextColumn get settingValueJson => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {settingKey};
}

