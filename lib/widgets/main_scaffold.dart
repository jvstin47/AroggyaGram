import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import 'glass_panel.dart';
import 'sos_button.dart';

import '../screens/dashboard_page.dart';
import '../screens/meds_tracker_page.dart';
import '../screens/pharmacy_page.dart';
import '../screens/translate_page.dart';
import '../screens/gemini_page.dart';
import '../screens/emergency_fallback_page.dart';
import '../screens/medication_alarm_page.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final currentScreen = navProvider.currentScreen;

    // Resolve active tab index
    int activeTabIndex = -1;
    if (currentScreen == AppScreen.dashboard) {
      activeTabIndex = 0;
    } else if (currentScreen == AppScreen.medsTracker) {
      activeTabIndex = 1;
    }

    Widget bodyWidget;
    switch (navProvider.currentScreen) {
      case AppScreen.dashboard:
        bodyWidget = const DashboardPage();
        break;
      case AppScreen.medsTracker:
        bodyWidget = const MedsTrackerPage();
        break;
      case AppScreen.pharmacy:
        bodyWidget = const PharmacyPage();
        break;
      case AppScreen.translate:
        bodyWidget = const TranslatePage();
        break;
      case AppScreen.gemini:
        bodyWidget = const GeminiConsultationPage();
        break;
      case AppScreen.emergencyFallback:
        bodyWidget = const EmergencyFallbackPage();
        break;
      case AppScreen.medicationAlarm:
        bodyWidget = const MedicationAlarmPage();
        break;
    }

    return PopScope(
      canPop: !navProvider.canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        navProvider.pop();
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Active page content
            bodyWidget,

            // Floating Bottom Navigation System (strictly centered and constant width 280)
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: _buildBottomNav(context, activeTabIndex, navProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int activeTabIndex, NavigationProvider navProvider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // SOS Button hovering above the pill
        const SosButton(size: 64.0),

        // Negative margin to overlap the pill slightly as in the design
        const SizedBox(height: -32),

        // Glass Navigation Pill
        GlassPanel(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: 40,
          child: SizedBox(
            width: 280, // Fixed width 280 strictly across all screens
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  icon: Icons.home_filled,
                  label: "HOME",
                  isActive: activeTabIndex == 0,
                  onTap: () => navProvider.setTab(AppScreen.dashboard),
                ),

                // Spacer for the SOS button gap
                const SizedBox(width: 48),

                _buildNavItem(
                  context: context,
                  icon: Icons.medication,
                  label: "MEDICINES",
                  isActive: activeTabIndex == 1,
                  onTap: () => navProvider.setTab(AppScreen.medsTracker),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant.withOpacity(0.6),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
