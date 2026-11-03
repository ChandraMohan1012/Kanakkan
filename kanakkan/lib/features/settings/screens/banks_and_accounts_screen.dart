import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../core/widgets/kanakkan_app_bar.dart';
import '../../../data/local/app_database.dart';
import '../../../data/local/daos/bank_dao.dart';

class BanksAndAccountsScreen extends StatefulWidget {
  final AppDatabase db;
  final BankDao bankDao;

  const BanksAndAccountsScreen({
    super.key,
    required this.db,
    required this.bankDao,
  });

  @override
  State<BanksAndAccountsScreen> createState() => _BanksAndAccountsScreenState();
}

class _BanksAndAccountsScreenState extends State<BanksAndAccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KanakkanAppBar(
        title: 'Banks & Accounts',
        showProfile: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<List<Account>>(
        stream: widget.db.select(widget.db.accounts).watch(),
        builder: (context, snapshot) {
          final accounts = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Info description card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.account_balance_rounded,
                      color: AppColors.primaryContainer,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Accounts Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'LINKED ACCOUNTS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppColors.outline,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showAddAccountDialog(context),
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: const Text('Add Account'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryContainer,
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              if (accounts.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                    children: [
                      Icon(Icons.credit_card_off_rounded, size: 36, color: AppColors.outline),
                      SizedBox(height: 8),
                      Text(
                        'No accounts configured yet',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Accounts are auto-detected from SMS or can be added manually.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.outline),
                      ),
                    ],
                  ),
                )
              else
                ...accounts.map((acc) => _AccountCard(
                      account: acc,
                      onToggleOwnAccount: (isOwn) async {
                        await (widget.db.update(widget.db.accounts)
                              ..where((tbl) => tbl.id.equals(acc.id)))
                            .write(
                          AccountsCompanion(
                            isOwnAccount: drift.Value(isOwn),
                          ),
                        );
                      },
                      onToggleArchive: () async {
                        await (widget.db.update(widget.db.accounts)
                              ..where((tbl) => tbl.id.equals(acc.id)))
                            .write(
                          AccountsCompanion(
                            isArchived: drift.Value(!acc.isArchived),
                          ),
                        );
                      },
                      onDelete: () async {
                        await (widget.db.delete(widget.db.accounts)
                              ..where((tbl) => tbl.id.equals(acc.id)))
                            .go();
                      },
                    )),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  void _showAddAccountDialog(BuildContext context) {
    final bankNameController = TextEditingController();
    final digitsController = TextEditingController();
    final nicknameController = TextEditingController();
    bool isOwnAccount = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Add Account', style: TextStyle(fontWeight: FontWeight.w700)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: bankNameController,
                  decoration: const InputDecoration(
                    labelText: 'Bank Name',
                    hintText: 'e.g. Canara Bank, HDFC',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: digitsController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: const InputDecoration(
                    labelText: 'Last 4 Digits',
                    hintText: 'e.g. 1234',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                    labelText: 'Nickname (Optional)',
                    hintText: 'e.g. Salary A/c, Savings',
                  ),
                ),
                const SizedBox(height: 14),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Own Account', style: TextStyle(fontSize: 14)),
                  subtitle: const Text(
                    'Transfers to/from this account are not counted as spends or income.',
                    style: TextStyle(fontSize: 11, color: AppColors.outline),
                  ),
                  value: isOwnAccount,
                  activeColor: AppColors.primaryContainer,
                  onChanged: (val) => setDialogState(() => isOwnAccount = val),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final digits = digitsController.text.trim();
                final bankName = bankNameController.text.trim();
                if (digits.isEmpty || bankName.isEmpty) return;

                final accountId = 'acc_$digits';
                await widget.bankDao.upsertAccount(
                  AccountsCompanion(
                    id: drift.Value(accountId),
                    bankName: drift.Value(bankName),
                    last4Digits: drift.Value(digits),
                    nickname: drift.Value(nicknameController.text.trim().isEmpty ? null : nicknameController.text.trim()),
                    isOwnAccount: drift.Value(isOwnAccount),
                    runningBalancePaise: const drift.Value(0),
                  ),
                );

                if (ctx.mounted) Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Account'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final Account account;
  final ValueChanged<bool> onToggleOwnAccount;
  final VoidCallback onToggleArchive;
  final VoidCallback onDelete;

  const _AccountCard({
    required this.account,
    required this.onToggleOwnAccount,
    required this.onToggleArchive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_rounded,
                      size: 18,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.nickname ?? account.bankName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        '${account.bankName} ••${account.last4Digits}',
                        style: const TextStyle(fontSize: 12, color: AppColors.outline),
                      ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded, size: 20, color: AppColors.outline),
                onSelected: (val) {
                  if (val == 'archive') onToggleArchive();
                  if (val == 'delete') onDelete();
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    value: 'archive',
                    child: Text(account.isArchived ? 'Unarchive' : 'Archive Account'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete Account', style: TextStyle(color: AppColors.error)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tracked Balance', style: TextStyle(fontSize: 11, color: AppColors.outline)),
                  Text(
                    CurrencyUtils.formatPaise(account.runningBalancePaise),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: account.isOwnAccount
                          ? AppColors.secondaryContainer
                          : AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      account.isOwnAccount ? 'Own Account' : 'External',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: account.isOwnAccount
                            ? AppColors.onSecondaryContainer
                            : AppColors.outline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (account.isArchived)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Archived',
                        style: TextStyle(fontSize: 11, color: AppColors.outline),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

