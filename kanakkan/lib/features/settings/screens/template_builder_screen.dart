import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kanakkan_app_bar.dart';
import '../../../data/local/app_database.dart';
import '../../../data/local/daos/bank_dao.dart';
import '../../../sms/template_model.dart';

enum TokenType { amount, payee, date, reference, balance }

class TemplateBuilderScreen extends StatefulWidget {
  final AppDatabase db;
  final BankDao bankDao;
  final String? initialSender;
  final String? initialBody;

  const TemplateBuilderScreen({
    super.key,
    required this.db,
    required this.bankDao,
    this.initialSender,
    this.initialBody,
  });

  @override
  State<TemplateBuilderScreen> createState() => _TemplateBuilderScreenState();
}

class _TemplateBuilderScreenState extends State<TemplateBuilderScreen> {
  int _currentStep = 0; // 0: Sender, 1: Tagging, 2: Preview

  late TextEditingController _senderController;
  late TextEditingController _bankNameController;
  late TextEditingController _bodyController;
  String _txnType = 'debit'; // 'debit' or 'credit'

  List<String> _words = [];
  final Map<int, TokenType> _taggedWords = {};
  TokenType _selectedTokenType = TokenType.amount;

  @override
  void initState() {
    super.initState();
    _senderController = TextEditingController(text: widget.initialSender ?? 'CANBNK');
    _bankNameController = TextEditingController(text: 'Canara Bank');
    _bodyController = TextEditingController(
      text: widget.initialBody ??
          'Dear Customer, INR 450.00 debited from A/c ..1234 to Sharma Tea Stall on 03/11/2026 via UPI Ref 430291823812. Avail Bal: Rs.32,400.00.',
    );
    _splitWords();
  }

  void _splitWords() {
    _words = _bodyController.text.split(RegExp(r'\s+'));
    _taggedWords.clear();
  }

  Color _getTokenColor(TokenType type) {
    switch (type) {
      case TokenType.amount:
        return AppColors.primaryContainer;
      case TokenType.payee:
        return AppColors.tertiary;
      case TokenType.date:
        return const Color(0xFF2563EB); // Blue
      case TokenType.reference:
        return const Color(0xFF7C3AED); // Purple
      case TokenType.balance:
        return const Color(0xFF059669); // Green
    }
  }

  String _getTokenLabel(TokenType type) {
    switch (type) {
      case TokenType.amount:
        return 'Amount';
      case TokenType.payee:
        return 'Payee';
      case TokenType.date:
        return 'Date';
      case TokenType.reference:
        return 'UPI Ref';
      case TokenType.balance:
        return 'Balance';
    }
  }

  String _getWordsForToken(TokenType type) {
    final indices = _taggedWords.entries
        .where((e) => e.value == type)
        .map((e) => e.key)
        .toList()
      ..sort();

    return indices.map((i) => _words[i]).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KanakkanAppBar(
        title: 'Bank Template Builder',
        showProfile: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Stepper indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: AppColors.surfaceContainerLowest,
            child: Row(
              children: [
                _StepBadge(step: 1, label: 'Sender', isActive: _currentStep == 0, isDone: _currentStep > 0),
                Expanded(child: Container(height: 2, color: _currentStep > 0 ? AppColors.primaryContainer : AppColors.surfaceContainerHigh)),
                _StepBadge(step: 2, label: 'Tag Words', isActive: _currentStep == 1, isDone: _currentStep > 1),
                Expanded(child: Container(height: 2, color: _currentStep > 1 ? AppColors.primaryContainer : AppColors.surfaceContainerHigh)),
                _StepBadge(step: 3, label: 'Preview', isActive: _currentStep == 2, isDone: false),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildStepContent(),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border(top: BorderSide(color: AppColors.surfaceContainerHigh.withOpacity(0.6))),
            ),
            child: Row(
              children: [
                if (_currentStep > 0) ...[
                  OutlinedButton(
                    onPressed: () => setState(() => _currentStep--),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onNextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: Text(_currentStep == 2 ? 'Save Template' : 'Next Step'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildSenderStep();
      case 1:
        return _buildTaggingStep();
      case 2:
        return _buildPreviewStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSenderStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 1: Bank & SMS Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          'Identify the bank name and SMS header sender code.',
          style: TextStyle(fontSize: 12, color: AppColors.outline),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _bankNameController,
          decoration: const InputDecoration(
            labelText: 'Bank Name',
            hintText: 'e.g. Canara Bank, HDFC, SBI',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _senderController,
          decoration: const InputDecoration(
            labelText: 'Sender ID / Pattern',
            hintText: 'e.g. CANBNK, HDFCBK, SBIINB',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Text('Transaction Type: ', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('Debit'),
              selected: _txnType == 'debit',
              onSelected: (val) => setState(() => _txnType = 'debit'),
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('Credit'),
              selected: _txnType == 'credit',
              onSelected: (val) => setState(() => _txnType = 'credit'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _bodyController,
          maxLines: 4,
          onChanged: (_) => _splitWords(),
          decoration: const InputDecoration(
            labelText: 'Sample SMS Message',
            hintText: 'Paste a real SMS from this bank...',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildTaggingStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 2: Tap Words to Assign Tokens',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          'Select a token below, then tap words in the message to highlight them.',
          style: TextStyle(fontSize: 12, color: AppColors.outline),
        ),
        const SizedBox(height: 14),

        // Token Type Selector Chips
        Wrap(
          spacing: 8,
          children: TokenType.values.map((type) {
            final isSelected = _selectedTokenType == type;
            final color = _getTokenColor(type);
            return ChoiceChip(
              label: Text(_getTokenLabel(type)),
              selected: isSelected,
              selectedColor: color.withOpacity(0.2),
              side: BorderSide(color: isSelected ? color : AppColors.outlineVariant),
              labelStyle: TextStyle(
                color: isSelected ? color : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 12,
              ),
              onSelected: (_) => setState(() => _selectedTokenType = type),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // Interactive Tappable Word Canvas
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceContainerHigh),
          ),
          child: Wrap(
            spacing: 6,
            runSpacing: 8,
            children: List.generate(_words.length, (index) {
              final word = _words[index];
              final taggedType = _taggedWords[index];

              return InkWell(
                onTap: () {
                  setState(() {
                    if (taggedType == _selectedTokenType) {
                      _taggedWords.remove(index);
                    } else {
                      _taggedWords[index] = _selectedTokenType;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: taggedType != null
                        ? _getTokenColor(taggedType).withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: taggedType != null
                          ? _getTokenColor(taggedType)
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    word,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: taggedType != null ? FontWeight.w700 : FontWeight.normal,
                      color: taggedType != null
                          ? _getTokenColor(taggedType)
                          : AppColors.onSurface,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewStep() {
    final amountText = _getWordsForToken(TokenType.amount);
    final payeeText = _getWordsForToken(TokenType.payee);
    final dateText = _getWordsForToken(TokenType.date);
    final refText = _getWordsForToken(TokenType.reference);
    final balanceText = _getWordsForToken(TokenType.balance);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 3: Verification & Live Preview',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          'Verify that the tokens were captured properly before saving.',
          style: TextStyle(fontSize: 12, color: AppColors.outline),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _PreviewRow(label: 'Bank', value: _bankNameController.text),
              _PreviewRow(label: 'Sender ID', value: _senderController.text),
              _PreviewRow(label: 'Type', value: _txnType.toUpperCase()),
              const Divider(height: 20),
              _PreviewRow(label: 'Amount Extracted', value: amountText.isEmpty ? 'Not set' : amountText, isHighlight: true),
              _PreviewRow(label: 'Payee Extracted', value: payeeText.isEmpty ? 'Not set' : payeeText),
              _PreviewRow(label: 'Date Extracted', value: dateText.isEmpty ? 'Not set' : dateText),
              _PreviewRow(label: 'UPI Ref Extracted', value: refText.isEmpty ? 'Not set' : refText),
              _PreviewRow(label: 'Balance Extracted', value: balanceText.isEmpty ? 'None' : balanceText),
            ],
          ),
        ),
      ],
    );
  }

  void _onNextStep() async {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      // Step 3: Save to SQLite
      final bankId = 'bank_${_bankNameController.text.trim().toLowerCase().replaceAll(' ', '_')}';
      await widget.bankDao.insertBank(
        BanksCompanion(
          id: drift.Value(bankId),
          name: drift.Value(_bankNameController.text.trim()),
          primaryColor: const drift.Value('#0F766E'),
        ),
      );

      final templateId = 'tpl_${DateTime.now().millisecondsSinceEpoch}';
      final template = BankTemplate(
        id: templateId,
        bankName: _bankNameController.text.trim(),
        senderIds: [_senderController.text.trim()],
        txnType: _txnType == 'credit' ? TransactionType.credit : TransactionType.debit,
        pattern: r'(.*)', // Generated pattern placeholder
        dateFormat: 'dd/MM/yyyy',
        currencyKeywords: ['INR', 'Rs.', '₹'],
        tokenMap: {
          'amount': '1',
          'payee': '2',
        },
      );

      await widget.bankDao.insertTemplate(template, bankId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Template saved successfully!')),
        );
        Navigator.pop(context);
      }
    }
  }
}

class _StepBadge extends StatelessWidget {
  final int step;
  final String label;
  final bool isActive;
  final bool isDone;

  const _StepBadge({
    required this.step,
    required this.label,
    required this.isActive,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive || isDone ? AppColors.primaryContainer : AppColors.outline;
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isDone ? AppColors.primaryContainer : (isActive ? AppColors.secondaryContainer : AppColors.surfaceContainerHigh),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: isDone
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : Text('$step', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: isActive ? FontWeight.w700 : FontWeight.w500, color: color),
        ),
      ],
    );
  }
}

class _PreviewRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;

  const _PreviewRow({required this.label, required this.value, this.isHighlight = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.outline)),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
              color: isHighlight ? AppColors.primaryContainer : AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
