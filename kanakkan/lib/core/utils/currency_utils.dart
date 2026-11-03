import 'package:intl/intl.dart';

/// Utilities for Indian Rupee currency handling in Kanakkan.
/// All monetary values in the database are strictly stored as integers in **paise**
/// (1 Rupee = 100 paise) to prevent floating-point rounding errors.
class CurrencyUtils {
  /// Converts a string representation of Rupees (e.g. "12,600.50", "40", "INR 1,250")
  /// into an exact integer representing **paise**.
  static int parseRupeesToPaise(String amountStr) {
    if (amountStr.trim().isEmpty) return 0;

    // Remove any currency prefixes, commas, and whitespace
    final cleaned = amountStr
        .replaceAll(RegExp(r'(INR|Rs\.?|₹|\s|,)+', caseSensitive: false), '')
        .trim();

    if (cleaned.isEmpty) return 0;

    final parts = cleaned.split('.');
    final rupees = int.tryParse(parts[0]) ?? 0;
    var paise = 0;

    if (parts.length > 1) {
      final decimalPart = parts[1];
      if (decimalPart.length == 1) {
        paise = (int.tryParse(decimalPart) ?? 0) * 10;
      } else if (decimalPart.length >= 2) {
        paise = int.tryParse(decimalPart.substring(0, 2)) ?? 0;
      }
    }

    return (rupees * 100) + paise;
  }

  /// Formats paise into Indian localized currency string (e.g. `₹1,25,000` or `₹40.50`).
  static String formatPaise(
    int paise, {
    bool includeSymbol = true,
    bool showDecimals = false,
    String symbol = '₹',
  }) {
    final isNegative = paise < 0;
    final absPaise = paise.abs();
    final rupees = absPaise ~/ 100;
    final remainingPaise = absPaise % 100;

    // Format integer rupees according to Indian numbering system (Lakhs & Crores)
    final indianFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '',
      decimalDigits: 0,
    );
    final formattedRupees = indianFormat.format(rupees).trim();

    final prefix = isNegative ? '-$symbol' : (includeSymbol ? symbol : '');

    if (showDecimals || remainingPaise > 0) {
      final paddedPaise = remainingPaise.toString().padLeft(2, '0');
      return '$prefix$formattedRupees.$paddedPaise';
    }

    return '$prefix$formattedRupees';
  }
}
