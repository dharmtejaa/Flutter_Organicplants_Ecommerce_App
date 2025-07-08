import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // ——— Enhanced brand colors ———
  static final Color primaryColor = Color(0xFF2E7D32); // Deeper green
  static final Color primaryLightColor = Color(0xFF4CAF50); // Lighter green
  static const Color secondaryColor = Color(0xFFFF6F00);
  static const Color accentColor = Color(0xFF66BB6A);

  // ——— Enhanced Light palette ———
  static final Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightCard = Colors.white;
  static const Color lightSurface = Color(0xFFF5F5F5);

  // ——— Enhanced Dark palette ———
  static final Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF2C2C2C);

  // ——— Accents ———
  static final Color offerColor = Color(0xFFE53935);
  static final Color starColor = Color(0xFFFFB300);
  static final Color successColor = Color(0xFF43A047);
  static final Color warningColor = Color(0xFFFF9800);

  // ---------------------------------------------------------------------------
  // ENHANCED LIGHT THEME
  // ---------------------------------------------------------------------------
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    brightness: Brightness.light,

    // Enhanced Scaffold
    scaffoldBackgroundColor: lightBackground,

    // Enhanced ColorScheme
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      primaryContainer: primaryLightColor.withValues(alpha: 0.1),
      secondary: secondaryColor,
      secondaryContainer: secondaryColor.withValues(alpha: 0.1),
      surface: lightSurface,
      surfaceContainerHighest: lightCard,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF666666),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      outline: Color(0xFFE0E0E0),
      outlineVariant: Color(0xFFF0F0F0),
    ),

    // Enhanced AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: lightBackground,
      foregroundColor: Color(0xFF1A1A1A),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        fontFamily: 'Poppins',
      ),
      iconTheme: IconThemeData(color: Color(0xFF1A1A1A), size: 24),
    ),

    // Enhanced Card Theme
    cardTheme: CardThemeData(
      color: lightCard,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Enhanced Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF666666),
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF666666),
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF666666),
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Color(0xFF999999),
        fontFamily: 'Poppins',
      ),
    ),

    // Enhanced Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: primaryColor.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    ),

    // Enhanced Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    ),

    // Enhanced Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFD32F2F)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: TextStyle(
        color: Color(0xFF999999),
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // ENHANCED DARK THEME
  // ---------------------------------------------------------------------------
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    brightness: Brightness.dark,

    // Enhanced Scaffold
    scaffoldBackgroundColor: darkBackground,

    // Enhanced ColorScheme
    colorScheme: ColorScheme.dark(
      primary: primaryLightColor,
      primaryContainer: primaryLightColor.withValues(alpha: 0.2),
      secondary: secondaryColor,
      secondaryContainer: secondaryColor.withValues(alpha: 0.2),
      surface: darkSurface,
      surfaceContainerHighest: darkCard,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onSurfaceVariant: Colors.white70,
      error: Color(0xFFEF5350),
      onError: Colors.black,
      outline: Color(0xFF424242),
      outlineVariant: Color(0xFF616161),
    ),

    // Enhanced AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: primaryLightColor,
        fontFamily: 'Poppins',
      ),
      iconTheme: IconThemeData(color: Colors.white, size: 24),
    ),

    // Enhanced Card Theme
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Enhanced Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Colors.white54,
        fontFamily: 'Poppins',
      ),
    ),

    // Enhanced Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLightColor,
        foregroundColor: Colors.black,
        elevation: 4,
        shadowColor: primaryLightColor.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    ),

    // Enhanced Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLightColor,
        side: BorderSide(color: primaryLightColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    ),

    // Enhanced Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF424242)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF424242)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryLightColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFEF5350)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: TextStyle(
        color: Colors.white54,
        fontSize: 14,
        fontFamily: 'Poppins',
      ),
    ),
  );
}
