import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:kanakkan/sms/template_model.dart';
import 'package:kanakkan/sms/templates/canara_templates.dart';
import 'app_database.dart';

class DatabaseSeeder {
  final AppDatabase db;

  DatabaseSeeder(this.db);

  Future<void> seedInitialData() async {
    await _seedBanksAndTemplates();
    await _seedDefaultCategories();
    await _seedDefaultSettings();
  }

  Future<void> _seedBanksAndTemplates() async {
    const canaraBankId = 'bank_canara';
    await db.into(db.banks).insertOnConflictUpdate(
          const BanksCompanion(
            id: Value(canaraBankId),
            name: Value('Canara Bank'),
            primaryColor: Value('#00838F'),
          ),
        );

    for (final template in CanaraTemplates.allSeedTemplates) {
      await db.into(db.bankTemplatesTable).insertOnConflictUpdate(
            BankTemplatesTableCompanion(
              id: Value(template.id),
              bankId: const Value(canaraBankId),
              bankName: Value(template.bankName),
              senderIds: Value(jsonEncode(template.senderIds)),
              txnType: Value(
                template.txnType == TransactionType.credit ? 'credit' : 'debit',
              ),
              pattern: Value(template.pattern),
              dateFormat: Value(template.dateFormat),
              currencyKeywords: Value(jsonEncode(template.currencyKeywords)),
              tokenMap: Value(jsonEncode(template.tokenMap)),
              version: Value(template.version),
              isActive: const Value(true),
            ),
          );
    }
  }

  Future<void> _seedDefaultCategories() async {
    final defaultCategories = [
      // Needs
      const CategoriesCompanion(
        id: Value('cat_housing'),
        name: Value('Housing & Rent'),
        icon: Value('home'),
        budgetType: Value('need'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_utilities'),
        name: Value('Utilities & Bills'),
        icon: Value('bolt'),
        budgetType: Value('need'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_groceries'),
        name: Value('Groceries & Kitchen'),
        icon: Value('shopping_cart'),
        budgetType: Value('need'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_healthcare'),
        name: Value('Healthcare & Meds'),
        icon: Value('local_hospital'),
        budgetType: Value('need'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_commute'),
        name: Value('Commute & Fuel'),
        icon: Value('directions_car'),
        budgetType: Value('need'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_investments'),
        name: Value('Investments & Savings'),
        icon: Value('savings'),
        budgetType: Value('need'),
        isCustom: Value(false),
      ),

      // Wants
      const CategoriesCompanion(
        id: Value('cat_dining'),
        name: Value('Dining & Swiggy'),
        icon: Value('restaurant'),
        budgetType: Value('want'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_shopping'),
        name: Value('Shopping & Apparel'),
        icon: Value('shopping_bag'),
        budgetType: Value('want'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_entertainment'),
        name: Value('Entertainment & Subs'),
        icon: Value('movie'),
        budgetType: Value('want'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_personal'),
        name: Value('Personal Care & Grooming'),
        icon: Value('spa'),
        budgetType: Value('want'),
        isCustom: Value(false),
      ),
      const CategoriesCompanion(
        id: Value('cat_miscellaneous'),
        name: Value('Miscellaneous'),
        icon: Value('more_horiz'),
        budgetType: Value('want'),
        isCustom: Value(false),
      ),
    ];

    for (final cat in defaultCategories) {
      await db.into(db.categories).insertOnConflictUpdate(cat);
    }
  }

  Future<void> _seedDefaultSettings() async {
    final settings = [
      const UserSettingsCompanion(
        settingKey: Value('buffer_paise'),
        settingValueJson: Value('200000'), // ₹2,000 buffer
      ),
      const UserSettingsCompanion(
        settingKey: Value('quiet_hours'),
        settingValueJson: Value(
          '{"enabled": true, "start": "22:00", "end": "08:00"}',
        ),
      ),
      const UserSettingsCompanion(
        settingKey: Value('recurring_tolerances'),
        settingValueJson: Value(
          '{"fixed_pct": 10, "variable_pct": 25, "days_window": 3, "missed_days": 5}',
        ),
      ),
      const UserSettingsCompanion(
        settingKey: Value('small_spend_threshold_paise'),
        settingValueJson: Value('10000'), // ₹100
      ),
      const UserSettingsCompanion(
        settingKey: Value('currency_symbol'),
        settingValueJson: Value('"₹"'),
      ),
    ];

    for (final s in settings) {
      await db.into(db.userSettings).insertOnConflictUpdate(s);
    }
  }
}
