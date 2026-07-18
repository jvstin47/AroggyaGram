import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../widgets/neumorphic_container.dart';
import '../widgets/glass_panel.dart';

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              bottom: 120, // Space if it ever has bottom nav overlay
            ),
            children: [
              // AI Suggestion Banner
              GlassPanel(
                backgroundColor: AppTheme.background.withOpacity(0.7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: AppTheme.secondaryFixed,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.lightbulb, color: AppTheme.onSecondaryContainer),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI Health Insight",
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: AppTheme.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Based on your recent prescription history, you might need a refill for Vitamin C supplements. High demand in your area right now.",
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
              ),
              const SizedBox(height: 32),

              // Product Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.65, // Adjust for tall cards
                children: [
                  _buildProductCard(
                    context,
                    title: "Paracetamol",
                    subtitle: "500mg • 10 Tablets",
                    price: "₹370.00",
                    imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBVtOCckAHeaE9-YIJCRV6-qFxfImmpZXeeOCRjKxnd0lmQ9k0PzWYSLxDbox_tqub1uP9kyLim-MuH0CJCbCr5ParGDd3OKi35mjWqHWgs4Miq51RKkEw83Cu_kANTnZke_OjoaLAS9kD9Hwa_rSAJuc1iVaerEHKYACuh_t7c1VBkTqSn7AeNkNdoePBlwe93YnR06QpDNQZ1sZWh-yXC-RYyiQIs_Qc3VriUjJdY2Bqn1nLTKblfIUDaOn89bh3Bv5Mk4CX8qyA",
                  ),
                  _buildProductCard(
                    context,
                    title: "Amoxicillin",
                    subtitle: "250mg • 20 Caps",
                    price: "₹980.00",
                    imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBryIcJ1z2xaqiLAb39nGbMDv_c1ARZwblPKccD2CohpXzhwZ1Sxls5I2ybjwkjaoU1yU_Nx9MlUFLWyYBBn_0LxfT8q460Jyj5HwmC7uPxN7ug9BQq9xYZ4Qtv9_oGPfFKRwXfLXmEOfYNuvhMxhPUAK4iIpXUuHpAmPTBtND09LWk0ulHU6wtHGggVssuAR6t_kz7FFk_2ECfSJd6ZDfCM5kXOn4mEOjOfkZJIQYrqtZTfQJjBsSpLHBHB7xGlsSi4Rx6pVmnmoA",
                  ),
                  _buildProductCard(
                    context,
                    title: "ORS Pack",
                    subtitle: "Electrolyte • 5 Pkts",
                    price: "₹550.00",
                    imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBIZjqQFpbxfXgPLhK5X15bDUtFKOg0ttIKCTlYuv-xjfAT0Es--g_06lerUd1ooAKt72xSUs57VItcG4jVySxGj01FjUF3Gqv4tiV7CbB3AcGQnoRC7jwX9e63Iof7uRbKcDMhQXHl0dAffVqR1ptj6eOSqArrDbGRABJN7upRH362OyI2pkvmoxUx9qiGfjSyazrbwmapYJzMcS_w9ruaMmUo_TxbYVwya3KXk8iiFIPcX2KUYIzwnyZjKGU_5u_4X6_NWhdlVVA",
                  ),
                  _buildProductCard(
                    context,
                    title: "Vitamin C",
                    subtitle: "1000mg • 30 Tabs",
                    price: "₹1250.00",
                    imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAzA0fC9n6IW53AggS7rakzBXF1tbVZ6-JNrGAocMVAPQ3Mmsf_dYy156StC1cbbScF92iifjkDNJuo016mwlrQ0p8jNtB3aGqY6kH505oqoRc60BZrrkcIY6rd1cDoT1bwzozXB3OUy0NeYbOvhZ5CACBwa6GAQz-cAeIXyA5UXMykKKGDqaolLAimOOzul034pDRZkATSZeOxuu7iCXR2omKCbt0Ic3V4psm0Baste-l6c8kTNq-eslwWObhKGTlEwoH3_icOtMY",
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),

          // Custom Top App Bar (Glass)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: AppTheme.background.withOpacity(0.7),
                    border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.read<NavigationProvider>().pop(),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_back, color: AppTheme.primary),
                                const SizedBox(width: 4),
                                Text(
                                  "BACK",
                                  style: TextStyle(
                                    color: AppTheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Pharmacy",
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.search, color: AppTheme.primary),
                          const SizedBox(width: 16),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.primaryFixed,
                              image: const DecorationImage(
                                image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuDbyqW5T3MjFPm_wajeh2-8VoZzV8B316zUXuACfnQpK_J26DjdDwQAjtMALwtAG2F9-wqqbylHXnMeu8gj9j19clYyC7B13YeaijrAvBudrCZuI74t8ABSBSQQWH7OhV5YrSeG3uJGX-oD6_9UvhBPltGf7dV0PTU362t5BmbsHs2eqwwwdRrLCP4y_dTWICa9A51JafNcNEwbQ6dxR0sPZGNaoW0MrqbJVP4jDI55E-nyIED5dz80wLXa1pIxC3E1FXFjkIbID34"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildProductCard(BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required String imageUrl,
  }) {
    return NeumorphicContainer(
      padding: const EdgeInsets.all(12),
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Coming Soon: Online ordering is disabled in this PoC."),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text("BUY", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
