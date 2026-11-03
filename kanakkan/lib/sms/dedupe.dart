import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Deduplication Key Engine for Kanakkan.
/// Prevents double-counting from duplicated SMS or multiple bank alerts.
class DedupeEngine {
  /// Computes the primary unique key:
  /// Primary Key: UPI reference + account digits + amount (in paise).
  static String computePrimaryKey({
    required String upiRef,
    required String accountDigits,
    required int amountPaise,
  }) {
    final cleanRef = upiRef.trim().toUpperCase();
    final cleanAcc = accountDigits.trim();
    final rawKey = 'PRIMARY:$cleanRef:$cleanAcc:$amountPaise';
    return sha256.convert(utf8.encode(rawKey)).toString();
  }

  /// Computes the fallback key if the UPI reference is missing, generic, or repeats:
  /// Fallback Key: amount (in paise) + payee + date (yyyy-MM-dd) + balance (in paise).
  static String computeFallbackKey({
    required int amountPaise,
    required String payee,
    required DateTime date,
    int? balancePaise,
  }) {
    final cleanPayee = payee.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    final dateStr = '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final bal = balancePaise ?? -1;
    final rawKey = 'FALLBACK:$amountPaise:$cleanPayee:$dateStr:$bal';
    return sha256.convert(utf8.encode(rawKey)).toString();
  }
}

