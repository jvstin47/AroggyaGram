import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../widgets/neumorphic_container.dart';
import '../widgets/glass_panel.dart';

class MedicationAlarmPage extends StatelessWidget {
  const MedicationAlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // The Circular Timer Ring
          Center(
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.background,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryFixedDim.withOpacity(0.4),
                    blurRadius: 40,
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer border simulating the ring
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryFixedDim,
                        width: 12,
                      ),
                    ),
                  ),
                  // Countdown Text
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "04:59",
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: AppTheme.primary,
                              fontFamily: 'JetBrains Mono',
                              fontSize: 64,
                            ),
                      ),
                      Text(
                        "REMAINING",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                              letterSpacing: 2.0,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Top Info (Glass)
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: GlassPanel(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              borderRadius: 24,
              child: Row(
                children: [
                  const Icon(Icons.medication, color: AppTheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time for Amoxicillin",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: AppTheme.primary,
                                fontSize: 18,
                              ),
                        ),
                        Text(
                          "1 Pill • After Meal",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action
          Positioned(
            bottom: 60,
            left: 32,
            right: 32,
            child: NeumorphicContainer(
              isInteractive: true,
              onTap: () => context.read<NavigationProvider>().pop(),
              color: AppTheme.primary,
              borderRadius: 32,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    "TAKE MEDICINE",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          
          Positioned(
             bottom: 24,
             left: 0,
             right: 0,
             child: Center(
               child: GestureDetector(
                 onTap: () => context.read<NavigationProvider>().pop(),
                 child: Text(
                   "Snooze for 10 mins",
                   style: Theme.of(context).textTheme.labelLarge?.copyWith(
                     color: AppTheme.outline,
                     decoration: TextDecoration.underline,
                   )
                 ),
               )
             ),
          ),
        ],
      ),
    );
  }
}
