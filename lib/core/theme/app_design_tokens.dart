import 'package:flutter/material.dart';

/// Single source-of-truth design tokens (Issue #175's "Design Tokens
/// — the smallest atoms of your UI") consumed by both [AppTheme]
/// (Material) and [AppShadTheme] (shadcn_ui) instead of each
/// duplicating its own hex literals. Flat, no glassmorphism — this
/// repo's fixed no-BackdropFilter palette rule; the issue's literal
/// "Glassmorphism Constants" and React/Tailwind sync don't apply (no
/// React web app exists here; see PR notes).
class AppDesignTokens {
  // --- Color (surface) ---
  static const darkBackground = Color(0xFF09090B);
  static const darkCard = Color(0xFF18181B);
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFFFFFF);

  static Color background(Brightness brightness) =>
      brightness == Brightness.dark ? darkBackground : lightBackground;
  static Color card(Brightness brightness) => brightness == Brightness.dark ? darkCard : lightCard;

  // --- Color (brand palette, Issue #1) ---
  static const lightPrimary = Color(0xFF2563EB);
  static const darkPrimary = Color(0xFF3B82F6);
  static const lightSecondary = Color(0xFF10B981);
  static const darkSecondary = Color(0xFF34D399);
  static const lightError = Color(0xFFEF4444);
  static const darkError = Color(0xFFF87171);
  static const lightTextPrimary = Color(0xFF1E293B);
  static const darkTextPrimary = Color(0xFFF1F5F9);

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
