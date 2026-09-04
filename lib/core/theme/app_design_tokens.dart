import 'package:flutter/material.dart';

/// Single source-of-truth design tokens (Issue #175's "Design Tokens
/// — the smallest atoms of your UI") consumed by both [AppTheme]
/// (Material) and [AppShadTheme] (shadcn_ui) instead of each
/// duplicating its own hex literals. Flat, no glassmorphism — this
/// repo's fixed no-BackdropFilter palette rule; the issue's literal
/// "Glassmorphism Constants" and React/Tailwind sync don't apply (no
/// React web app exists here; see PR notes).
///
/// [Issue #784] Warm redesign: surfaces and brand colors moved from a
/// cool zinc/blue palette to a warm amber/orange one. Surfaces keep a
/// slight brown/cream tint instead of pure black/white so the warmth
/// carries through backgrounds, not just accents.
class AppDesignTokens {
  // --- Color (surface) ---
  static const darkBackground = Color(0xFF1C1210);
  static const darkCard = Color(0xFF2A1F1A);
  static const lightBackground = Color(0xFFFFFBF5);
  static const lightCard = Color(0xFFFFF8F0);

  static Color background(Brightness brightness) =>
      brightness == Brightness.dark ? darkBackground : lightBackground;
  static Color card(Brightness brightness) => brightness == Brightness.dark ? darkCard : lightCard;

  // --- Color (brand palette, Issue #1, warmed for Issue #784) ---
  // Matches shadcn_ui's own ShadOrangeColorScheme primary per mode, so the
  // Material and shadcn_ui layers render the identical orange.
  static const lightPrimary = Color(0xFFF97316);
  static const darkPrimary = Color(0xFFEA580C);
  static const lightSecondary = Color(0xFFD97706);
  static const darkSecondary = Color(0xFFFBBF24);
  static const lightError = Color(0xFFDC2626);
  static const darkError = Color(0xFFF87171);

  /// [Issue #784] Dedicated success green for status icons/notifications —
  /// kept separate from the warm primary/secondary so "success" stays
  /// instantly recognizable regardless of the app's warm accent colors.
  static const success = Color(0xFF16A34A);
  static const lightTextPrimary = Color(0xFF2A1607);
  static const darkTextPrimary = Color(0xFFFDF4E7);

  static Color primary(Brightness brightness) =>
      brightness == Brightness.dark ? darkPrimary : lightPrimary;
  static Color secondary(Brightness brightness) =>
      brightness == Brightness.dark ? darkSecondary : lightSecondary;
  static Color error(Brightness brightness) =>
      brightness == Brightness.dark ? darkError : lightError;
  static Color textPrimary(Brightness brightness) =>
      brightness == Brightness.dark ? darkTextPrimary : lightTextPrimary;

  // --- Spacing (4pt grid) ---
  static const spaceXs = 4.0;
  static const spaceSm = 8.0;
  static const spaceMd = 12.0;
  static const spaceLg = 16.0;
  static const spaceXl = 24.0;
  static const spaceXxl = 32.0;

  // --- Radius ---
  static const radiusSm = 8.0;
  static const radiusMd = 12.0;
  static const radiusLg = 16.0;
}
