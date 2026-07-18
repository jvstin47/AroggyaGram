import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/medication_provider.dart';
import '../widgets/neumorphic_container.dart';
import '../widgets/glass_panel.dart';

class MedsTrackerPage extends StatefulWidget {
  const MedsTrackerPage({super.key});

  @override
  State<MedsTrackerPage> createState() => _MedsTrackerPageState();
}

class _MedsTrackerPageState extends State<MedsTrackerPage> {
  // Helpers for mockup data
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();

  void _showAddMedDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.background,
        title: Text("Add Medication", style: Theme.of(context).textTheme.headlineMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Medicine Name"),
            ),
            TextField(
              controller: _timeCtrl,
              decoration: const InputDecoration(labelText: "Time (e.g. 08:00 AM)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
            onPressed: () {
              if (_nameCtrl.text.isNotEmpty && _timeCtrl.text.isNotEmpty) {
                Provider.of<MedicationProvider>(context, listen: false)
                    .addMedicine(_nameCtrl.text, _timeCtrl.text, "1 Pill");
                _nameCtrl.clear();
                _timeCtrl.clear();
                Navigator.pop(ctx);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medsProvider = Provider.of<MedicationProvider>(context);
    final meds = medsProvider.meds;
    final total = meds.length;
    final taken = meds.where((m) => m['taken'] == true).length;
    final progress = total > 0 ? (taken / total) : 0.0;

    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120.0), // Above the navigation pill
        child: FloatingActionButton(
          backgroundColor: Colors.white.withOpacity(0.9),
          foregroundColor: AppTheme.primary,
          elevation: 8,
          onPressed: _showAddMedDialog,
          child: const Icon(Icons.add, size: 32),
        ),
      ),
      body: Stack(
        children: [
          // Scrollable Content
          ListView(
            padding: const EdgeInsets.only(
              top: 100, // Space for custom app bar
              left: 20,
              right: 20,
              bottom: 160,
            ),
            children: [
              // Medication List
              if (meds.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text("No medications added yet. Tap + to add one."),
                  ),
                )
              else
                ...meds.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Map<String, dynamic> med = entry.value;
                  return _buildMedCard(context, med, idx, medsProvider);
                }),

              const SizedBox(height: 32),

              // AI Insight Panel
              GlassPanel(
                backgroundColor: Colors.white.withOpacity(0.65),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: AppTheme.secondary),
                        const SizedBox(width: 8),
                        Text(
                          "AI HEALTH INSIGHT",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.secondary,
                                letterSpacing: 2.0,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Consistency with your medications is excellent this week. Keep taking them on time to maintain stable health.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Custom Top App Bar (Glass)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.4))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.menu, color: AppTheme.primary),
                          const SizedBox(width: 12),
                          Text(
                            "Medication Tracker",
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                          color: AppTheme.surfaceContainerHigh,
                          image: const DecorationImage(
                            image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAu-ZRPQfAqjs2fSWo8tacyiBuv9BFLKFb1LwR6ApKjknhCUFBIECN_O1tyOg-Id8_8YK6jlDQ1f9mT1GTJWUrtn62z0xKl7TbJLZ4ECvHPot1lozw7jLidbk3-LNi71NF08CsQTFfC2FA9hOU_-TywXQkaIRmwDV9ZD4zLwN3vwQKuktltTAWGRVF7c1iDD6MLdtN60_8CpI2AszUFYb8lcLWq9jawfW3gpvqszB7kkLoMXh4XBEgHCDz2yDiH_gOWkGWbgIU_NmM"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedCard(BuildContext context, Map<String, dynamic> med, int index, MedicationProvider provider) {
    final isChecked = med['taken'] == true;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: NeumorphicContainer(
        borderRadius: 24,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.medication, color: AppTheme.primaryContainer, size: 28),
            ),
            const SizedBox(width: 16),
            
            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    med['name'],
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.primary,
                        ),
                  ),
                  Text(
                    "Scheduled Dosage",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 16, color: AppTheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(
                        med['time'],
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 14,
                              color: AppTheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Custom Neumorphic Checkbox
            GestureDetector(
              onTap: () {
                provider.toggleTaken(index, !isChecked);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked ? AppTheme.primaryFixed : AppTheme.background,
                  boxShadow: isChecked
                      ? [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(-4, -4),
                            blurRadius: 8,
                          ),
                          BoxShadow(
                            color: AppTheme.neumorphicDark,
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(-4, -4),
                            blurRadius: 8,
                          ),
                          BoxShadow(
                            color: AppTheme.neumorphicDark,
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                          ),
                        ],
                ),
                child: Center(
                  child: AnimatedScale(
                    scale: isChecked ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
