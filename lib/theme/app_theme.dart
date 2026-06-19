import 'package:flutter/material.dart';

/// Soft lavender and cream palette for CozyVerse.
abstract final class AppColors {
  static const Color cream = Color(0xFFFFF8F0);
  static const Color creamSurface = Color(0xFFFFFBF5);
  static const Color lavender = Color(0xFFB8A9C9);
  static const Color lavenderLight = Color(0xFFD4C5E8);
  static const Color lavenderDark = Color(0xFF8B7BA8);
  static const Color textPrimary = Color(0xFF3D3548);
  static const Color textSecondary = Color(0xFF6B6178);
}

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.lavender,
      brightness: Brightness.light,
      primary: AppColors.lavenderDark,
      onPrimary: Colors.white,
      secondary: AppColors.lavender,
      onSecondary: AppColors.textPrimary,
      surface: AppColors.creamSurface,
      onSurface: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.cream,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.creamSurface,
        indicatorColor: AppColors.lavenderLight.withValues(alpha: 0.6),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.lavenderDark,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.lavenderDark);
          }
          return const IconThemeData(color: AppColors.textSecondary);
        }),
      ),
      cardTheme: CardThemeData(
        color: AppColors.creamSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lavenderLight.withValues(alpha: 0.4)),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
