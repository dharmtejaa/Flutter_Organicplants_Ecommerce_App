import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organicplants/core/services/app_sizes.dart';

class AppTheme {
  // ——— Enhanced brand colors ———
  //static final Color primaryColor = Color(0xFF2E7D32); // Deeper green
  static final Color primaryColor = Color(0xFF4CAF50);
  static final Color onPrimary = Color(0xffffffff); // Lighter green

  // ignore: deprecated_member_use
  static final Color primaryContainer = primaryColor.withOpacity(0.1);
  static final Color onPrimaryContianer = Color(0xFFDCDCDC);

  static const Color secondaryColor = Color(0xFFFF6F00);
  static const Color accentColor = Color(0xFF66BB6A);

  // ——— Enhanced Light palette ———
  static final Color lightBackground = Color(0xFFF0F0F0);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color onLightSurface = Color(0xFF1A1A1A);
  static const Color lightInverseSurface = Color(0xFFF5F5F5);
  static const Color onLightInverseSurface = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF1A1A1A);
  static const Color lightOnSurfaceVariant = Color(0xFF666666);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnCard = Color(0xFF1A1A1A);
  static const Color lightOnError = Color(0xFFD32F2F);
  static const Color lightError = Color(0xFFFFCDD2);

  // ——— Enhanced Dark palette ———
  static final Color darkBackground = Color(0xF0000000);
  static final Color onDarkBackground = Color(0xFFDCDCDC);

  static const Color darkCard = Color(0xFF1E1E1E);

  static const Color darksurface = Color(0xFF1a1a1a);
  static const Color onDarkSurface = Color(0xFFDCDCDC);

  static const Color darkinverseSurface = Color(0xff1e1e1e);
  static const Color onDarkInverseSurface = Color(0xffDCDCDC);

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
      primaryContainer: primaryColor.withValues(alpha: 0.1),
      secondary: secondaryColor,
      secondaryContainer: secondaryColor.withValues(alpha: 0.1),
      surface: lightSurface,
      surfaceContainerHighest: lightBackground,
      inverseSurface: lightInverseSurface,
      onInverseSurface: onLightInverseSurface,
      onPrimary: onPrimary,
      onSecondary: onLightSurface,
      onSurface: onLightSurface,
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
        fontSize: 38.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor, // Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xffA0A0A0),
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor, //Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
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
        fontSize: 16.sp,
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
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),

      labelLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white, //Color(0xFF666666),
        fontFamily: 'Poppins',
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1A1A1A),
        fontFamily: 'Poppins',
      ),
    ),

    // Enhanced Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        //elevation: 2,
        //shadowColor: primaryColor.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: 16.sp,
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

    // Enhanced ExpansionTile Theme
    expansionTileTheme: ExpansionTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide.none,
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide.none,
      ),
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      iconColor: primaryColor,
      collapsedIconColor: primaryColor,
      textColor: Color(0xFF1A1A1A),
      collapsedTextColor: Color(0xFF1A1A1A),
    ),

    dividerColor: Colors.transparent,
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
      primary: primaryColor,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      secondary: secondaryColor,
      secondaryContainer: secondaryColor.withValues(alpha: 0.2),
      surface: darksurface,
      onSurface: onDarkSurface,
      inverseSurface: darkinverseSurface,
      onInverseSurface: onDarkInverseSurface,

      //onSurfaceContainer: Color(0xFF1E1E1E),
      onSecondary: Colors.white70,
      onSurfaceVariant: Colors.white70,
      error: Color(0xFFEF5350),
      onError: Colors.black,
      outline: Color(0xff6a6a6a),
      outlineVariant: darksurface,
    ),

    // Enhanced AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: onPrimary,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: onPrimary,
        fontFamily: 'Poppins',
      ),
      iconTheme: IconThemeData(color: onPrimary, size: AppSizes.iconMd),
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
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w500,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
      //used in search feild
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: onDarkBackground, //Colors.white,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: onDarkBackground, //Colors.white,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: onDarkBackground, //Colors.white,
        fontFamily: 'Poppins',
      ),
      //onPrimary content for pirmary content
      labelLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: onPrimary,
        fontFamily: 'Poppins',
        overflow: TextOverflow.ellipsis,
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
      //used for very small labels like term and policy
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: onDarkSurface,
        fontFamily: 'Poppins',
      ),
    ),

    // Enhanced Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
        elevation: 2,
        shadowColor: primaryColor.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: 16,
          color: onPrimary,
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
          fontSize: 16.sp,
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
        borderSide: BorderSide(color: primaryColor, width: 2),
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

    // Enhanced ExpansionTile Theme
    expansionTileTheme: ExpansionTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        side: BorderSide.none,
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        side: BorderSide.none,
      ),
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      iconColor: primaryColor,
      collapsedIconColor: primaryColor,
      textColor: onDarkSurface,
      collapsedTextColor: onDarkSurface,
    ),

    //dividerColor: Colors.transparent,
  );
}
