import 'dart:convert';

enum TransactionType {
  debit,
  credit,
  transfer;

  static TransactionType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'credit':
        return TransactionType.credit;
      case 'transfer':
        return TransactionType.transfer;
      case 'debit':
      default:
        return TransactionType.debit;
    }
  }
}

/// Dynamic Bank Template Model.
/// Stored in SQLite database so new banks and template updates can be loaded without an app update.
class BankTemplate {
  final String id;
  final String bankName;
  final List<String> senderIds;
  final TransactionType txnType;
  final String pattern;
  final String dateFormat;
  final List<String> currencyKeywords;
  final Map<String, dynamic> tokenMap;
  final int version;
  final bool isActive;

  const BankTemplate({
    required this.id,
    required this.bankName,
    required this.senderIds,
    required this.txnType,
    required this.pattern,
    required this.dateFormat,
    required this.currencyKeywords,
    required this.tokenMap,
    this.version = 1,
    this.isActive = true,
  });

  /// Check whether an SMS sender header matches this template
  bool matchesSender(String sender) {
    final normalized = sender.trim().toUpperCase();
    return senderIds.any((s) =>
        normalized == s.toUpperCase() ||
        normalized.endsWith('-${s.toUpperCase()}') ||
        normalized.contains(s.toUpperCase()));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bank_name': bankName,
      'sender_ids': jsonEncode(senderIds),
      'txn_type': txnType.name,
      'pattern': pattern,
      'date_format': dateFormat,
      'currency_keywords': jsonEncode(currencyKeywords),
      'token_map': jsonEncode(tokenMap),
      'version': version,
      'is_active': isActive ? 1 : 0,
    };
  }

  factory BankTemplate.fromMap(Map<String, dynamic> map) {
    return BankTemplate(
      id: map['id'] as String,
      bankName: map['bank_name'] as String,
      senderIds: (jsonDecode(map['sender_ids'] as String) as List)
          .map((e) => e.toString())
          .toList(),
      txnType: TransactionType.fromString(map['txn_type'] as String),
      pattern: map['pattern'] as String,
      dateFormat: map['date_format'] as String,
      currencyKeywords: (jsonDecode(map['currency_keywords'] as String) as List)
          .map((e) => e.toString())
          .toList(),
      tokenMap: jsonDecode(map['token_map'] as String) as Map<String, dynamic>,
      version: map['version'] as int? ?? 1,
      isActive: (map['is_active'] as int? ?? 1) == 1,
    );
  }
}

