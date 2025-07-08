import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static Color primaryGreen = Color(0xFF2E7D32);
  static Color primaryLightGreen = Color(0xFF4CAF50);
  static Color primaryDarkGreen = Color(0xFF1B5E20);

  // Secondary Colors
  static Color secondaryOrange = Color(0xFFFF6F00);
  static Color secondaryLightOrange = Color(0xFFFF8A50);

  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color secondaryBackground = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surfaceBackground = Color(0xFFF8F9FA);

  // Text Colors
  static const Color heading = Color(0xFF1A1A1A);
  static const Color subheading = Color(0xFF424242);
  static const Color text = Color(0xFF666666);
  static const Color mutedText = Color(0xFF9E9E9E);
  static const Color lightText = Color(0xFFBDBDBD);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderDark = Color(0xFFBDBDBD);

  // Accent Colors
  static const Color accent = Color(0xFF66BB6A);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Status Colors
  static const Color online = Color(0xFF4CAF50);
  static const Color offline = Color(0xFF9E9E9E);
  static const Color pending = Color(0xFFFF9800);

  // Rating Colors
  static const Color starFilled = Color(0xFFFFB300);
  static const Color starEmpty = Color(0xFFE0E0E0);

  // Price Colors
  static const Color originalPrice = Color(0xFF9E9E9E);
  static const Color offerPrice = Color(0xFF2E7D32);
  static const Color discount = Color(0xFFE53935);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFF6F00), Color(0xFFFF8A50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static Color shadowLight = Colors.black.withValues(alpha: 0.08);
  static Color shadowMedium = Colors.black.withValues(alpha: 0.12);
  static Color shadowDark = Colors.black.withValues(alpha: 0.24);

  // Overlay Colors
  static Color overlayLight = Colors.black.withValues(alpha: 0.1);
  static Color overlayMedium = Colors.black.withValues(alpha: 0.5);
  static Color overlayDark = Colors.black.withValues(alpha: 0.8);

  // Legacy Colors (for backward compatibility)
  static Color splashTextColor = primaryGreen;
}
