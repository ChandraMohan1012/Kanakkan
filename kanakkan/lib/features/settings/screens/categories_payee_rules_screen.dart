import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kanakkan_app_bar.dart';
import '../../../data/local/app_database.dart';

class CategoriesPayeeRulesScreen extends StatefulWidget {
  final AppDatabase db;

  const CategoriesPayeeRulesScreen({super.key, required this.db});

  @override
  State<CategoriesPayeeRulesScreen> createState() => _CategoriesPayeeRulesScreenState();
}

class _CategoriesPayeeRulesScreenState extends State<CategoriesPayeeRulesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KanakkanAppBar(
        title: 'Categories & Rules',
        showProfile: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surfaceContainerLowest,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primaryContainer,
              unselectedLabelColor: AppColors.outline,
              indicatorColor: AppColors.primaryContainer,
              tabs: const [
                Tab(text: 'Categories'),
                Tab(text: 'Payee Rules'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCategoriesTab(),
                _buildPayeesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return StreamBuilder<List<Category>>(
      stream: widget.db.select(widget.db.categories).watch(),
      builder: (context, snapshot) {
        final categories = snapshot.data ?? [];

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('50/30/20 ENVELOPES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.outline)),
            const SizedBox(height: 8),
            ...categories.map((cat) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: cat.budgetType == 'need'
                              ? AppColors.secondaryContainer.withOpacity(0.5)
                              : AppColors.tertiaryFixed.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          cat.budgetType == 'need' ? Icons.home_rounded : Icons.local_cafe_rounded,
                          size: 16,
                          color: cat.budgetType == 'need' ? AppColors.primaryContainer : AppColors.tertiary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          cat.name,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: cat.budgetType == 'need' ? AppColors.secondaryContainer : AppColors.tertiaryFixed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          cat.budgetType.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: cat.budgetType == 'need' ? AppColors.onSecondaryContainer : AppColors.onTertiaryFixedVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }

  Widget _buildPayeesTab() {
    return StreamBuilder<List<Payee>>(
      stream: widget.db.select(widget.db.payees).watch(),
      builder: (context, snapshot) {
        final payees = snapshot.data ?? [];

        if (payees.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No learned payee rules yet.\nTag an untagged spend to create automatic rules.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.outline, fontSize: 13),
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('AUTO-LEARNED PAYEES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.outline)),
            const SizedBox(height: 8),
            ...payees.map((p) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 2),
                            Text('Auto-tagged as ${p.defaultClassification ?? "Need"}', style: const TextStyle(fontSize: 11, color: AppColors.outline)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.error),
                        onPressed: () async {
                          await (widget.db.delete(widget.db.payees)..where((tbl) => tbl.id.equals(p.id))).go();
                        },
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}

