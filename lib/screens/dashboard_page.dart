import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/medication_provider.dart';
import '../providers/navigation_provider.dart';
import '../widgets/neumorphic_container.dart';
import '../widgets/glass_panel.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final medsProvider = Provider.of<MedicationProvider>(context);
    final meds = medsProvider.meds;
    final nextMedIndex = meds.indexWhere((m) => m['taken'] == false);
    final hasNextMed = nextMedIndex != -1;
    final nextMed = hasNextMed ? meds[nextMedIndex] : null;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Scrollable Content
          ListView(
            padding: const EdgeInsets.only(
              top: 100, // Space for custom app bar
              left: 20,
              right: 20,
              bottom: 120, // Space for floating nav
            ),
            children: [
              // Welcome Header
              Row(
                children: [
                  Text(
                    "Hello 👋",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "AarogyaGram User",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 24),

              // Emergency Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: -20), // Bleed edge
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                color: AppTheme.error,
                child: Text(
                  "In an emergency, tap the SOS button below.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.onError,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 32),

              // 2x2 Neumorphic Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildGridButton(
                    context,
                    icon: Icons.local_pharmacy,
                    label: "Pharmacy",
                    iconColor: AppTheme.onPrimaryContainer,
                    iconBgColor: AppTheme.primaryContainer,
                    screen: AppScreen.pharmacy,
                  ),
                  _buildGridButton(
                    context,
                    icon: Icons.psychology,
                    label: "AI Consult",
                    iconColor: AppTheme.onSecondaryContainer,
                    iconBgColor: AppTheme.secondaryContainer,
                    screen: AppScreen.gemini,
                  ),
                  _buildGridButton(
                    context,
                    icon: Icons.medication,
                    label: "Medication",
                    iconColor: AppTheme.onPrimaryContainer,
                    iconBgColor: const Color(0xFF516661),
                    screen: AppScreen.medsTracker,
                  ),
                  _buildGridButton(
                    context,
                    icon: Icons.translate,
                    label: "Translate",
                    iconColor: AppTheme.onSurfaceVariant,
                    iconBgColor: AppTheme.surfaceContainerHighest,
                    screen: AppScreen.translate,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // AI Insight Panel
              GlassPanel(
                borderColor: Colors.black.withOpacity(0.05),
                backgroundColor: Colors.white.withOpacity(0.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bolt, color: AppTheme.secondary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "AI HEALTH INSIGHT",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.secondary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      hasNextMed 
                        ? "You have upcoming medications. Please stay on schedule." 
                        : (meds.isNotEmpty 
                            ? "Great job! You've taken all your scheduled medications for today." 
                            : "No medications scheduled. Stay hydrated and healthy!"),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Next Medicine Card
              NeumorphicContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "NEXT MEDICINE",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.onSurfaceVariant,
                              ),
                        ),
                        Icon(Icons.notifications_active, color: AppTheme.primary.withOpacity(0.4), size: 20),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasNextMed ? nextMed!['name'] : "All caught up!",
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      color: AppTheme.primary,
                                    ),
                              ),
                              if (hasNextMed)
                                Text(
                                  "Post Dinner", // Hardcoded context for visual matching, ideally from data
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppTheme.onSurfaceVariant,
                                      ),
                                ),
                            ],
                          ),
                        ),
                        if (hasNextMed)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryFixed.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              nextMed!['time'],
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppTheme.primary,
                                  ),
                            ),
                          ),
                      ],
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
                filter: _blurFilter(),
                child: Container(
                  height: 90, // Taller to account for status bar
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.menu, color: AppTheme.primary),
                          const SizedBox(width: 12),
                          Text(
                            "AarogyaGram",
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
                            image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAAUxQ5pw4xrV4-8YmphaDDxIJWLYQPs2x8NSY4QQh3pKzUVPSZ6p-eIhXnaqmDJyVrxHslN2fdEAZjoNJjPCgtS1FuVwZMVGSJvLBHEKkG2b4Ew4CbxkR-cu9hY2YrMuCuXeaFZWKODQ6bXkiu3XTeaTcoLfdCeV0cl0DkKTpWVq2PI0DtOWEC7ZOzPFP4xDyBWk78ilYTaroTn45EhF1xa4HAllqOMH9EJfOs_QLnVm08EWRy5HjyvqsKy6ImhXWBxo0lOfLkFlA"),
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

  Widget _buildGridButton(BuildContext context, {
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color iconBgColor,
    required AppScreen screen,
  }) {
    return NeumorphicContainer(
      isInteractive: true,
      onTap: () {
        if (screen == AppScreen.medsTracker) {
          context.read<NavigationProvider>().setTab(screen);
        } else {
          context.read<NavigationProvider>().push(screen);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.primary,
                ),
          ),
        ],
      ),
    );
  }

  ImageFilter _blurFilter() {
    return ImageFilter.blur(sigmaX: 16, sigmaY: 16);
  }
}
