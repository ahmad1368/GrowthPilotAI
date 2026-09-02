import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

/// The single canonical Material [ThemeData] (Issue #1) — flat bg #09090b
/// (dark) / #ffffff (light), matching [AppShadTheme] for screens that also
/// opt into shadcn_ui. Colors and typography sourced from
/// [AppDesignTokens] (Issue #175) instead of its own hex literals.
class AppTheme {
  static ThemeData light() => buildTheme(Brightness.light);
  static ThemeData dark() => buildTheme(Brightness.dark);

  static ThemeData buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final contentColor = isDark ? Colors.white : Colors.black;
    final primary = AppDesignTokens.primary(brightness);
    final secondary = AppDesignTokens.secondary(brightness);
    final error = AppDesignTokens.error(brightness);
    final textPrimary = AppDesignTokens.textPrimary(brightness);

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: AppDesignTokens.card(brightness),
      onSurface: textPrimary,
    );

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: AppDesignTokens.background(brightness),
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _textTheme(textPrimary),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: contentColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(100, 45),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Vazir'),
        ),
      ),
    );
  }

  /// Financial-figure-legible type scale (Issue #1 AC): headlineLarge
  /// 24sp/bold/-0.5 letter-spacing, bodyMedium 14sp/regular/1.5 line-height,
  /// labelSmall 12sp/medium for tabular transaction lists.
  static TextTheme _textTheme(Color textColor) {
    return TextTheme(
      headlineLarge: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: textColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
