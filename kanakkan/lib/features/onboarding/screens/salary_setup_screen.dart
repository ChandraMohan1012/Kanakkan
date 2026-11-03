import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/app_database.dart';

class SalarySetupScreen extends StatefulWidget {
  final AppDatabase db;
  final VoidCallback onSetupComplete;

  const SalarySetupScreen({
    super.key,
    required this.db,
    required this.onSetupComplete,
  });

  @override
  State<SalarySetupScreen> createState() => _SalarySetupScreenState();
}

class _SalarySetupScreenState extends State<SalarySetupScreen> {
  final _salaryController = TextEditingController(text: '45000');
  final _bufferController = TextEditingController(text: '2000');
  DateTime _expectedSalaryDate = DateTime.now().add(const Duration(days: 27));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Salary & Cycle Setup', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header description
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.calendar_month_rounded, color: AppColors.primaryContainer, size: 22),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your salary cycle and buffer determine your daily safe-to-spend pace.',
                        style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Expected Salary Input
              const Text(
                'EXPECTED MONTHLY SALARY',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.outline),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _salaryController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryContainer),
                decoration: InputDecoration(
                  prefixText: '₹ ',
                  prefixStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primaryContainer),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLowest,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // Safety Buffer Input
              const Text(
                'SAFETY BUFFER (UNTOUCHABLE)',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.outline),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _bufferController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  prefixText: '₹ ',
                  prefixStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLowest,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  helperText: 'Reserved for unexpected emergencies and never added to daily safe spend.',
                ),
              ),
              const SizedBox(height: 20),

              // Expected Next Salary Date
              const Text(
                'EXPECTED NEXT SALARY ARRIVAL',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: AppColors.outline),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _expectedSalaryDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                  );
                  if (picked != null) {
                    setState(() => _expectedSalaryDate = picked);
                  }
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.event_rounded, color: AppColors.primaryContainer, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            '${_expectedSalaryDate.day} / ${_expectedSalaryDate.month} / ${_expectedSalaryDate.year}',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Text(
                        'Change',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryContainer),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Complete Setup Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final salaryRupees = int.tryParse(_salaryController.text.trim()) ?? 45000;
                    final bufferRupees = int.tryParse(_bufferController.text.trim()) ?? 2000;

                    final cycleId = 'cycle_${DateTime.now().millisecondsSinceEpoch}';
                    await widget.db.into(widget.db.cycles).insert(
                          CyclesCompanion(
                            id: drift.Value(cycleId),
                            startDate: drift.Value(DateTime.now()),
                            expectedNextDate: drift.Value(_expectedSalaryDate),
                            confirmedSalaryPaise: drift.Value(salaryRupees * 100),
                            isActive: const drift.Value(true),
                          ),
                        );

                    await widget.db.into(widget.db.userSettings).insertOnConflictUpdate(
                          UserSettingsCompanion(
                            settingKey: const drift.Value('buffer_paise'),
                            settingValueJson: drift.Value('${bufferRupees * 100}'),
                          ),
                        );

                    widget.onSetupComplete();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text('Start My Cycle', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

