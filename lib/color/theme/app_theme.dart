import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  // متد استاتیک برای حالت روشن
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
        error: AppColors.error,
      ),
      textTheme: AppTypography.textTheme,
    );
  }

  // متد استاتیک برای حالت تاریک
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceDark, // اعمال سرمه‌ای تیره
        onSurface: AppColors.textPrimaryDark,
        error: AppColors.error,
      ),
      textTheme: AppTypography.textTheme,
    );
  }
}
