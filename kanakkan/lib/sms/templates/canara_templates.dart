import '../template_model.dart';

/// Seed Templates for Canara Bank.
/// These move from code into database seed rows so Canara is simply the first supported bank
/// in the dynamic database, requiring no special-casing in code.
class CanaraTemplates {
  static const List<String> canaraSenderIds = [
    'CANBNK',
    'VM-CANBNK',
    'VK-CANBNK',
    'BZ-CANBNK',
    'AD-CANBNK',
    'AX-CANBNK',
    'JD-CANBNK',
    'CP-CANBNK',
  ];

  /// 1. Canara UPI Debit Template
  /// - Date format: day/month/year (dd/MM/yyyy)
  /// - Carries available balance
  /// - UPI Reference
  static final BankTemplate upiDebit = BankTemplate(
    id: 'canara_upi_debit_v1',
    bankName: 'Canara Bank',
    senderIds: canaraSenderIds,
    txnType: TransactionType.debit,
    // Flexible regex matching:
    // Amount, A/c ending, Payee/Merchant, Date (dd/MM/yyyy), UPI Ref, and Avail Bal
    pattern: r'(?:INR|Rs\.?)\s*(?<amount>[\d,]+(?:\.\d{1,2})?)\s*(?:debited|deducted).*?(?:a/c|acct|ac)\D*(?<account>\d{3,4}).*?(?:to|at|for)\s+(?<payee>[^.]+?)\s+on\s+(?<date>\d{2}/\d{2}/\d{4}).*?(?:UPI\s*(?:Ref|txn|id)?\D*(?<ref>\w+)).*?(?:bal(?:ance)?|avail(?:able)?\s*bal(?:ance)?)\D*(?:INR|Rs\.?)?\s*(?<balance>[\d,]+(?:\.\d{1,2})?)',
    dateFormat: 'dd/MM/yyyy',
    currencyKeywords: ['INR', 'Rs.', 'Rs', '₹'],
    tokenMap: {
      'amount': 'amount',
      'account': 'account',
      'payee': 'payee',
      'date': 'date',
      'ref': 'ref',
      'balance': 'balance',
    },
    version: 1,
  );

  /// 2. Canara UPI Credit Template
  /// - Date format: month/day/year with time (MM/dd/yyyy HH:mm:ss or MM/dd/yyyy)
  /// - Carries NO balance
  static final BankTemplate upiCredit = BankTemplate(
    id: 'canara_upi_credit_v1',
    bankName: 'Canara Bank',
    senderIds: canaraSenderIds,
    txnType: TransactionType.credit,
    // Flexible regex matching:
    // A/c ending, Amount, Date (MM/dd/yyyy [time]), UPI Ref, and Optional Sender/Transfer Note
    pattern: r'(?:a/c|acct|ac)\D*(?<account>\d{3,4}).*?(?:is\s+)?credited\s+(?:with|for)?\s*(?:INR|Rs\.?)?\s*(?<amount>[\d,]+(?:\.\d{1,2})?)\s+on\s+(?<date>\d{2}/\d{2}/\d{4}(?:\s+\d{2}:\d{2}(?::\d{2})?)?).*?(?:UPI\s*(?:Ref|txn|id)?\D*(?<ref>\w+))(?:.*?(?:from|by)\s+(?<payee>[^.]+))?',
    dateFormat: 'MM/dd/yyyy HH:mm:ss',
    currencyKeywords: ['INR', 'Rs.', 'Rs', '₹'],
    tokenMap: {
      'amount': 'amount',
      'account': 'account',
      'payee': 'payee',
      'date': 'date',
      'ref': 'ref',
      'balance': null, // Canara credits carry NO balance
    },
    version: 1,
  );

  static List<BankTemplate> get allSeedTemplates => [upiDebit, upiCredit];
}
