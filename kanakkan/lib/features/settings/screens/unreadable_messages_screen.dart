import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kanakkan_app_bar.dart';
import '../../../data/local/app_database.dart';
import '../../../data/local/daos/bank_dao.dart';
import '../../../sms/unreadable_store.dart';
import 'template_builder_screen.dart';

class UnreadableMessagesScreen extends StatefulWidget {
  final AppDatabase db;
  final BankDao bankDao;
  final UnreadableStore unreadableStore;

  const UnreadableMessagesScreen({
    super.key,
    required this.db,
    required this.bankDao,
    required this.unreadableStore,
  });

  @override
  State<UnreadableMessagesScreen> createState() => _UnreadableMessagesScreenState();
}

class _UnreadableMessagesScreenState extends State<UnreadableMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final items = widget.unreadableStore.items.where((i) => !i.isIgnored).toList();

    return Scaffold(
      appBar: KanakkanAppBar(
        title: 'Unreadable Messages',
        showProfile: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.help_outline_rounded, color: AppColors.primaryContainer, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'These SMS messages did not match any active bank template. Tap "Teach App" to turn them into dynamic templates.',
                    style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (items.isEmpty)
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: const Column(
                children: [
                  Icon(Icons.check_circle_outline_rounded, size: 40, color: AppColors.primaryContainer),
                  SizedBox(height: 8),
                  Text('No Unreadable Messages', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  SizedBox(height: 4),
                  Text('All bank messages were parsed cleanly by active templates.', style: TextStyle(fontSize: 12, color: AppColors.outline)),
                ],
              ),
            )
          else
            ...items.map((msg) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              msg.sender,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            '${msg.receivedAt.day}/${msg.receivedAt.month}',
                            style: const TextStyle(fontSize: 11, color: AppColors.outline),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        msg.sanitizedBody,
                        style: const TextStyle(fontSize: 13, color: AppColors.onSurface, height: 1.3),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.unreadableStore.markIgnored(msg.id);
                              });
                            },
                            child: const Text('Dismiss', style: TextStyle(color: AppColors.outline, fontSize: 12)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TemplateBuilderScreen(
                                    db: widget.db,
                                    bankDao: widget.bankDao,
                                    initialSender: msg.sender,
                                    initialBody: msg.rawBody,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.build_rounded, size: 14),
                            label: const Text('Teach App', style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}

