import 'package:intl/intl.dart';
import '../core/utils/currency_utils.dart';
import 'dedupe.dart';
import 'template_model.dart';

/// Result of parsing an SMS transaction.
class ParsedTransaction {
  final int amountPaise;
  final String accountDigits;
  final String payee;
  final DateTime parsedDate;
  final DateTime receivedDate;
  final DateTime effectiveDate;
  final bool isDateFlagged;
  final String upiRef;
  final int? balancePaise;
  final TransactionType txnType;
  final String bankName;
  final String templateId;
  final String primaryDedupeHash;
  final String fallbackDedupeHash;
  final bool isFallbackGuess;
  final String rawBody;

  const ParsedTransaction({
    required this.amountPaise,
    required this.accountDigits,
    required this.payee,
    required this.parsedDate,
    required this.receivedDate,
    required this.effectiveDate,
    required this.isDateFlagged,
    required this.upiRef,
    required this.balancePaise,
    required this.txnType,
    required this.bankName,
    required this.templateId,
    required this.primaryDedupeHash,
    required this.fallbackDedupeHash,
    this.isFallbackGuess = false,
    required this.rawBody,
  });
}

/// Outcome of attempting to parse an SMS message.
class ParseResult {
  final ParsedTransaction? transaction;
  final bool isIgnoredOtpOrPromo;
  final String? unreadableReason;

  bool get isSuccess => transaction != null;

  const ParseResult._({
    this.transaction,
    this.isIgnoredOtpOrPromo = false,
    this.unreadableReason,
  });

  factory ParseResult.success(ParsedTransaction transaction) =>
      ParseResult._(transaction: transaction);

  factory ParseResult.ignored(String reason) => ParseResult._(
        isIgnoredOtpOrPromo: true,
        unreadableReason: reason,
      );

  factory ParseResult.unreadable(String reason) => ParseResult._(
        unreadableReason: reason,
      );
}

/// The Master SMS Parsing Engine for Kanakkan.
class SmsParser {
  final List<BankTemplate> activeTemplates;

  SmsParser({required this.activeTemplates});

  /// Primary parsing entrypoint.
  ParseResult parse({
    required String sender,
    required String rawBody,
    required DateTime receivedAt,
  }) {
    final cleanBody = _normalizeBody(rawBody);

    // 1. Guard against OTPs, verification codes, and promo notices
    if (_isOtpOrPromo(cleanBody)) {
      return ParseResult.ignored('OTP or promotional message ignored.');
    }

    // 2. Find matching templates for this sender ID
    final matchedTemplates =
        activeTemplates.where((t) => t.matchesSender(sender)).toList();

    for (final template in matchedTemplates) {
      final parsed = _tryMatchTemplate(
        template: template,
        cleanBody: cleanBody,
        rawBody: rawBody,
        receivedAt: receivedAt,
      );
      if (parsed != null) {
        return ParseResult.success(parsed);
      }
    }

    // 3. If templates for known sender failed or sender is unknown,
    // evaluate fallback parser heuristic
    final fallback = _tryFallbackKeywordParser(
      sender: sender,
      cleanBody: cleanBody,
      rawBody: rawBody,
      receivedAt: receivedAt,
    );

    if (fallback != null) {
      return ParseResult.success(fallback);
    }

    return ParseResult.unreadable(
      matchedTemplates.isEmpty
          ? 'Unknown bank sender ($sender).'
          : 'SMS did not match any active ${matchedTemplates.first.bankName} template.',
    );
  }

  /// Attempts to match a single BankTemplate against the normalized SMS.
  ParsedTransaction? _tryMatchTemplate({
    required BankTemplate template,
    required String cleanBody,
    required String rawBody,
    required DateTime receivedAt,
  }) {
    try {
      final regex = RegExp(template.pattern, caseSensitive: false, dotAll: true);
      final match = regex.firstMatch(cleanBody);
      if (match == null) return null;

      // Extract named groups from pattern
      final amountStr = match.namedGroup(template.tokenMap['amount'] ?? 'amount');
      final accountStr = match.namedGroup(template.tokenMap['account'] ?? 'account') ?? '0000';
      final payeeStr = match.namedGroup(template.tokenMap['payee'] ?? 'payee') ?? 'Unknown Payee';
      final dateStr = match.namedGroup(template.tokenMap['date'] ?? 'date');
      final refStr = match.namedGroup(template.tokenMap['ref'] ?? 'ref') ?? '';
      
      String? balanceStr;
      if (template.tokenMap['balance'] != null) {
        balanceStr = match.namedGroup(template.tokenMap['balance']!);
      }

      if (amountStr == null || dateStr == null) return null;

      final amountPaise = CurrencyUtils.parseRupeesToPaise(amountStr);
      final balancePaise =
          balanceStr != null ? CurrencyUtils.parseRupeesToPaise(balanceStr) : null;

      // Parse date with template's specific format
      final parsedDate = _parseDate(dateStr, template.dateFormat) ?? receivedAt;

      // Date reconciliation rule:
      // Time comes from phone's received time. If parsed date disagrees with received date,
      // trust the received date and flag the message.
      final isDateFlagged = !_isSameDay(parsedDate, receivedAt);
      final effectiveDate = receivedAt;

      final primaryHash = DedupeEngine.computePrimaryKey(
        upiRef: refStr,
        accountDigits: accountStr,
        amountPaise: amountPaise,
      );

      final fallbackHash = DedupeEngine.computeFallbackKey(
        amountPaise: amountPaise,
        payee: payeeStr,
        date: effectiveDate,
        balancePaise: balancePaise,
      );

      return ParsedTransaction(
        amountPaise: amountPaise,
        accountDigits: accountStr,
        payee: _cleanPayee(payeeStr),
        parsedDate: parsedDate,
        receivedDate: receivedAt,
        effectiveDate: effectiveDate,
        isDateFlagged: isDateFlagged,
        upiRef: refStr,
        balancePaise: balancePaise,
        txnType: template.txnType,
        bankName: template.bankName,
        templateId: template.id,
        primaryDedupeHash: primaryHash,
        fallbackDedupeHash: fallbackHash,
        isFallbackGuess: false,
        rawBody: rawBody,
      );
    } catch (_) {
      return null;
    }
  }

  /// Fallback Parser:
  /// For unknown banks or untemplated messages, guesses using common Indian banking keywords:
  /// (debited, credited, Dr., Cr., Rs, INR, UPI, Ref)
  ParsedTransaction? _tryFallbackKeywordParser({
    required String sender,
    required String cleanBody,
    required String rawBody,
    required DateTime receivedAt,
  }) {
    final lower = cleanBody.toLowerCase();

    // Must have at least a financial action and an amount
    final isDebit = lower.contains('debited') ||
        lower.contains('deducted') ||
        lower.contains('dr.') ||
        lower.contains('dr ');
    final isCredit = lower.contains('credited') ||
        lower.contains('cr.') ||
        lower.contains('cr ');

    if (!isDebit && !isCredit) return null;

    final txnType = isCredit ? TransactionType.credit : TransactionType.debit;

    // Extract Amount: e.g. "INR 500" or "Rs. 1,200.50" or "Rs 35"
    final amountMatch = RegExp(
            r'(?:INR|Rs\.?|₹)\s*([\d,]+(?:\.\d{1,2})?)', caseSensitive: false)
        .firstMatch(cleanBody);
    if (amountMatch == null) return null;
    final amountPaise = CurrencyUtils.parseRupeesToPaise(amountMatch.group(1)!);

    // Extract Account ending digits
    final accMatch =
        RegExp(r'(?:a/c|acct|ac|card)\D*(\d{3,4})', caseSensitive: false)
            .firstMatch(cleanBody);
    final accountDigits = accMatch != null ? accMatch.group(1)! : '0000';

    // Extract UPI Reference or Transaction ID
    final refMatch = RegExp(
            r'(?:UPI\s*(?:Ref|txn|id)?|Ref(?:erence)?(?:\s*no\.?)?|Txn\s*ID)\D*(\w{6,})',
            caseSensitive: false)
        .firstMatch(cleanBody);
    final upiRef = refMatch != null ? refMatch.group(1)! : '';

    // Extract Payee if present
    String payee = 'Unknown Merchant';
    final toMatch = RegExp(
            r'(?:to|at|for|from)\s+([A-Za-z0-9\s&.\-_]+?)(?:\s+(?:on|via|ref|bal|using)\b|[.,])',
            caseSensitive: false)
        .firstMatch(cleanBody);
    if (toMatch != null) {
      payee = toMatch.group(1)!.trim();
    }

    // Extract Balance if present
    int? balancePaise;
    final balMatch = RegExp(
            r'(?:bal(?:ance)?|avail(?:able)?\s*bal(?:ance)?)\D*(?:INR|Rs\.?)?\s*([\d,]+(?:\.\d{1,2})?)',
            caseSensitive: false)
        .firstMatch(cleanBody);
    if (balMatch != null) {
      balancePaise = CurrencyUtils.parseRupeesToPaise(balMatch.group(1)!);
    }

    final primaryHash = DedupeEngine.computePrimaryKey(
      upiRef: upiRef,
      accountDigits: accountDigits,
      amountPaise: amountPaise,
    );

    final fallbackHash = DedupeEngine.computeFallbackKey(
      amountPaise: amountPaise,
      payee: payee,
      date: receivedAt,
      balancePaise: balancePaise,
    );

    return ParsedTransaction(
      amountPaise: amountPaise,
      accountDigits: accountDigits,
      payee: _cleanPayee(payee),
      parsedDate: receivedAt,
      receivedDate: receivedAt,
      effectiveDate: receivedAt,
      isDateFlagged: false,
      upiRef: upiRef,
      balancePaise: balancePaise,
      txnType: txnType,
      bankName: sender.replaceAll(RegExp(r'^[A-Z]{2}-'), ''),
      templateId: 'fallback_heuristic',
      primaryDedupeHash: primaryHash,
      fallbackDedupeHash: fallbackHash,
      isFallbackGuess: true,
      rawBody: rawBody,
    );
  }

  /// Normalizes whitespace and standardizes common characters
  static String _normalizeBody(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Cleans payee names (normalizes casing, removes trailing punctuation and codes)
  static String _cleanPayee(String payee) {
    var clean = payee
        .replaceAll(RegExp(r'\b(?:UPI|IMPS|NEFT|Ref|No|Ltd|Pvt)\b', caseSensitive: false), '')
        .replaceAll(RegExp(r'[^\w\s&-]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (clean.isEmpty) return 'Unknown Payee';

    // Capitalize words neatly
    return clean.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Checks if message is an OTP, fraud warning only, or marketing notice
  static bool _isOtpOrPromo(String body) {
    final lower = body.toLowerCase();

    // Check for OTP patterns
    final hasOtp = RegExp(
            r'\b(?:otp|one\s*time\s*password|verification\s*code|security\s*code)\b')
        .hasMatch(lower);
    if (hasOtp && !lower.contains('debited') && !lower.contains('credited')) {
      return true;
    }

    // Check for purely promotional or informational alerts
    final isPromo = lower.contains('reward points') ||
        lower.contains('pre-approved loan') ||
        lower.contains('apply now') ||
        lower.contains('mandate alert') ||
        lower.contains('congratulations');
    if (isPromo && !lower.contains('debited') && !lower.contains('credited')) {
      return true;
    }

    return false;
  }

  /// Helper to safely parse localized dates
  static DateTime? _parseDate(String dateStr, String format) {
    try {
      final cleanDate = dateStr.trim();
      // Handle date format with or without time
      if (format.contains('HH:mm') && !cleanDate.contains(':')) {
        return DateFormat('MM/dd/yyyy').parseLoose(cleanDate);
      }
      return DateFormat(format).parseLoose(cleanDate);
    } catch (_) {
      try {
        return DateTime.tryParse(dateStr);
      } catch (_) {
        return null;
      }
    }
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
