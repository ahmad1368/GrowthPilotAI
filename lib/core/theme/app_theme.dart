import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

/// The single canonical Material [ThemeData] (Issue #1) — flat bg #09090b
/// (dark) / #ffffff (light), matching [AppShadTheme] for screens that also
/// opt into shadcn_ui. Colors now sourced from [AppDesignTokens] (Issue
/// #175) instead of its own hex literals.
class AppTheme {
  static ThemeData buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final contentColor = isDark ? Colors.white : Colors.black;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: AppDesignTokens.background(brightness),
      useMaterial3: true,
      colorSchemeSeed: isDark ? Colors.tealAccent : Colors.teal,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: contentColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDark ? Colors.tealAccent.shade700 : Colors.teal,
          foregroundColor: isDark ? Colors.black : Colors.white,
          minimumSize: const Size(100, 45),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Vazir'),
        ),
      ),
    );
  }
}
