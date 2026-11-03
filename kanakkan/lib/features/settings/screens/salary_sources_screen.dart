import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../core/widgets/kanakkan_app_bar.dart';
import '../../../data/local/app_database.dart';

class SalarySourcesScreen extends StatefulWidget {
  final AppDatabase db;

  const SalarySourcesScreen({super.key, required this.db});

  @override
  State<SalarySourcesScreen> createState() => _SalarySourcesScreenState();
}

class _SalarySourcesScreenState extends State<SalarySourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KanakkanAppBar(
        title: 'Salary Sources',
        showProfile: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<List<SalarySource>>(
        stream: widget.db.select(widget.db.salarySources).watch(),
        builder: (context, snapshot) {
          final sources = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              // Helper Explanation Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primaryContainer,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Salary amount and dates can change every month. When a recognized source credits your account, you will be prompted to start a new cycle.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Header & Add Source Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'CONFIGURED SOURCES',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppColors.outline,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showAddSourceDialog(context),
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: const Text('Add Source'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryContainer,
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              if (sources.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Column(
                    children: [
                      Icon(Icons.work_outline_rounded, size: 36, color: AppColors.outline),
                      SizedBox(height: 8),
                      Text(
                        'No salary sources added yet',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Add your employer or income source to track monthly salary cycles.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.outline),
                      ),
                    ],
                  ),
                )
              else
                ...sources.map((src) => _SalarySourceCard(
                      source: src,
                      onTogglePause: () async {
                        await (widget.db.update(widget.db.salarySources)
                              ..where((tbl) => tbl.id.equals(src.id)))
                            .write(
                          SalarySourcesCompanion(
                            isPaused: drift.Value(!src.isPaused),
                          ),
                        );
                      },
                      onDelete: () async {
                        await (widget.db.delete(widget.db.salarySources)
                              ..where((tbl) => tbl.id.equals(src.id)))
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

  void _showAddSourceDialog(BuildContext context) {
    final labelController = TextEditingController();
    final digitsController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add Salary Source', style: TextStyle(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: const InputDecoration(
                labelText: 'Source Label / Employer',
                hintText: 'e.g. Acme Corp, Client X',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: digitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sending Account Digits (Optional)',
                hintText: 'e.g. 5678',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final label = labelController.text.trim();
              if (label.isEmpty) return;

              final sourceId = 'src_${DateTime.now().millisecondsSinceEpoch}';
              await widget.db.into(widget.db.salarySources).insert(
                    SalarySourcesCompanion(
                      id: drift.Value(sourceId),
                      label: drift.Value(label),
                      sendingAccountDigits: drift.Value(
                        digitsController.text.trim().isEmpty ? null : digitsController.text.trim(),
                      ),
                      isPaused: const drift.Value(false),
                    ),
                  );

              if (ctx.mounted) Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save Source'),
          ),
        ],
      ),
    );
  }
}

class _SalarySourceCard extends StatelessWidget {
  final SalarySource source;
  final VoidCallback onTogglePause;
  final VoidCallback onDelete;

  const _SalarySourceCard({
    required this.source,
    required this.onTogglePause,
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
                      Icons.work_rounded,
                      size: 18,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        source.label,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                      if (source.sendingAccountDigits != null)
                        Text(
                          'From A/c ••${source.sendingAccountDigits}',
                          style: const TextStyle(fontSize: 12, color: AppColors.outline),
                        ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded, size: 20, color: AppColors.outline),
                onSelected: (val) {
                  if (val == 'pause') onTogglePause();
                  if (val == 'delete') onDelete();
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    value: 'pause',
                    child: Text(source.isPaused ? 'Resume Source' : 'Pause Source'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete Source', style: TextStyle(color: AppColors.error)),
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
                  const Text('Last Credited', style: TextStyle(fontSize: 11, color: AppColors.outline)),
                  Text(
                    source.lastCreditedAmountPaise != null
                        ? CurrencyUtils.formatPaise(source.lastCreditedAmountPaise!)
                        : 'No credits recorded',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: source.isPaused
                      ? AppColors.surfaceContainerHigh
                      : AppColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  source.isPaused ? 'Paused' : 'Active',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: source.isPaused
                        ? AppColors.outline
                        : AppColors.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

