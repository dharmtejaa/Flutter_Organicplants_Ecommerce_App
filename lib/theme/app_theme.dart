import 'package:flutter/material.dart';

class AppTheme {
  // ——— Shared brand colors ———
  static final Color primaryColor = Colors.green.shade400;
  static const Color secondaryColor = Color(0xFFFF6F00);

  // ——— Light palette ———
  static final Color lightBackground = Colors.white;
  static const Color lightCard = Colors.white;

  // ——— Dark palette (softer grays) ———
  static final Color darkBackground = const Color(
    0xFF121212,
  ); // was Colors.black
  static const Color darkCard = Color(0xFF2C2C2C); // was Colors.black87

  // ——— Accents ———
  static final Color offerColor = Colors.red;
  static final Color starColor = Colors.amber;

  // ---------------------------------------------------------------------------
  // LIGHT THEME
  // ---------------------------------------------------------------------------
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    brightness: Brightness.light,
    //Scaffold backgrougn Color
    scaffoldBackgroundColor: const Color(0xFFF0F0F0),
    //ColorScheme Theme
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: lightBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.grey,
      // ignore: deprecated_member_use
      onSurface: Colors.black.withOpacity(0.8),
      error: Color(0xFFD32F2F),
      onError: Colors.white,
    ),
    //AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF0F0F0),
      foregroundColor: Colors.black,
      elevation: 0,
      surfaceTintColor:
          Colors.transparent, // ⬅️ Prevents dynamic tint on scroll
    ),
    //Card Theme
    cardColor: lightCard,
    //Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );

  // ---------------------------------------------------------------------------
  // DARK THEME  (⬅️   updated colors only)
  // ---------------------------------------------------------------------------
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: const Color(0xFF1E1E1E), // was darkBackground
      onPrimary: Colors.black,
      onSecondary: Colors.white70,
      onSurface: Colors.white60,
      error: Color(0xFFD32F2F),
      onError: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground, // or your fixed color
      foregroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor:
          Colors.transparent, // ⬅️ Prevents dynamic tint on scroll
    ),
    cardColor: darkCard,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );
}
