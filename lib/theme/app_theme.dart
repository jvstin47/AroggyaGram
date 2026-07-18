import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Core Colors
  static const Color background = Color(0xFFFBFAF6);
  static const Color primary = Color(0xFF005448);
  static const Color primaryContainer = Color(0xFF0F6E5F);
  static const Color onPrimaryContainer = Color(0xFF9CEDDA);
  static const Color primaryFixedDim = Color(0xFF84D5C3);
  static const Color primaryFixed = Color(0xFFA0F2DF);
  
  static const Color secondary = Color(0xFF835400);
  static const Color secondaryContainer = Color(0xFFFDB244);
  static const Color onSecondaryContainer = Color(0xFF6E4600);
  static const Color secondaryFixed = Color(0xFFFFDDB5);
  static const Color secondaryFixedDim = Color(0xFFFFB956);
  
  static const Color error = Color(0xFFD62828);
  static const Color onError = Color(0xFFFFFFFF);

  // Surface Colors (derived from warm off-white #FBFAF6)
  static const Color surfaceContainerHighest = Color(0xFFEBEAE6);
  static const Color surfaceContainerHigh = Color(0xFFF0EFEA);
  static const Color surfaceContainer = Color(0xFFF5F4EF);
  static const Color surfaceContainerLow = Color(0xFFFAF9F4);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  
  static const Color onSurface = Color(0xFF121E1C);
  static const Color onSurfaceVariant = Color(0xFF3E4946);
  static const Color outline = Color(0xFF6E7976);
  static const Color outlineVariant = Color(0xFFBEC9C5);

  // Neumorphic Shadows
  static const Color neumorphicLight = Color(0xFFFFFFFF);
  static const Color neumorphicDark = Color(0x0D1E2A28); // rgba(30, 42, 40, 0.05)
  static const Color neumorphicDarker = Color(0x141E2A28); // rgba(30, 42, 40, 0.08)

  // Typography
  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.notoSans(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.64, height: 40/32),
      displayMedium: GoogleFonts.notoSans(fontSize: 26, fontWeight: FontWeight.w700, height: 32/26),
      headlineMedium: GoogleFonts.notoSans(fontSize: 22, fontWeight: FontWeight.w600, height: 28/22),
      bodyLarge: GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w400, height: 24/16),
      bodyMedium: GoogleFonts.notoSans(fontSize: 14, fontWeight: FontWeight.w400, height: 20/14),
      labelSmall: GoogleFonts.notoSans(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.6, height: 16/12),
      labelLarge: GoogleFonts.jetBrainsMono(fontSize: 18, fontWeight: FontWeight.w500, height: 24/18), // Used for tabular data
    );
  }

  static ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: background,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: onSurface,
        onError: Colors.white,
      ),
      textTheme: textTheme,
      useMaterial3: true,
    );
  }
}
