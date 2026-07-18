import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../providers/settings_provider.dart';
import '../providers/navigation_provider.dart';

class SosButton extends StatefulWidget {
  final double size;

  const SosButton({super.key, this.size = 64.0});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _glowAnimation = Tween<double>(begin: 0.0, end: 15.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onPressed() async {
    if (_isSending) return;
    setState(() => _isSending = true);

    final settings = Provider.of<SettingsProvider>(context, listen: false);
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);

    // 1. Instantly navigate to fallback screen so the user knows action is being taken
    navProvider.push(AppScreen.emergencyFallback);

    String smsBody = "EMERGENCY! I need help immediately. (Location unavailable)";
    
    try {
      // 2. Request Location Permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever) {
        // 3. Get GPS coordinates if permission is granted
        Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 5),
        );
        smsBody = "EMERGENCY! My location: https://www.google.com/maps?q=${pos.latitude},${pos.longitude}";
      }
    } catch (e) {
      // Fallback to sending SMS without location if location fails (e.g. timeout or hardware issue)
      debugPrint("Location retrieval failed: $e");
    }

    // 4. Open SMS with contact (or fallback if permission denied)
    try {
      final url = "sms:${settings.emergencyContact}?body=${Uri.encodeComponent(smsBody)}";
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint("Could not launch SMS: $e");
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.error.withOpacity(
                  (1.0 - _controller.value).clamp(0.0, 0.4),
                ),
                spreadRadius: _glowAnimation.value,
                blurRadius: 10,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Material(
        color: AppTheme.error,
        shape: const CircleBorder(),
        elevation: 8.0,
        child: InkWell(
          onTap: _onPressed,
          customBorder: const CircleBorder(),
          child: const Center(
            child: Icon(
              Icons.emergency,
              color: Colors.white,
              size: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}
