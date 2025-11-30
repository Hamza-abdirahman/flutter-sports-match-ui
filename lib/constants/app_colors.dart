import 'package:flutter/material.dart';

/// App color constants following the Figma design
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Dark theme background colors
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF000000);
  static const Color darkCardBg = Color(0xFF252525);

  // Primary colors
  static const Color primary = Color(0xFF5D3FD3);
  static const Color primaryLight = Color(0xFF7A5AFF);
  static const Color primaryDark = Color(0xFF4A2FBF);

  // Accent colors
  static const Color accentRed = Color(0xFFFF4444);
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentYellow = Color(0xFFFFD700);
  static const Color accentBlue = Color(0xFF00B4FF);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);

  // Border & divider colors
  static const Color borderColor = Color(0xFF3A3A3A);
  static const Color dividerColor = Color(0xFF2A2A2A);

  // Status colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFFF4444);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color infoBlue = Color(0xFF2196F3);

  // Special gradient colors
  static const Color gradientBlueStart = Color(0xFF0066FF);
  static const Color gradientBlueEnd = Color(0xFF0099FF);
}
