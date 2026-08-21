import 'package:flutter/material.dart';

/// Single source-of-truth design tokens (Issue #175's "Design Tokens
/// — the smallest atoms of your UI") consumed by both [AppTheme]
/// (Material) and [AppShadTheme] (shadcn_ui) instead of each
/// duplicating its own hex literals. Flat, no glassmorphism — this
/// repo's fixed no-BackdropFilter palette rule; the issue's literal
/// "Glassmorphism Constants" and React/Tailwind sync don't apply (no
/// React web app exists here; see PR notes).
class AppDesignTokens {
  // --- Color ---
  static const darkBackground = Color(0xFF09090B);
  static const darkCard = Color(0xFF18181B);
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFFFFFF);

  static Color background(Brightness brightness) =>
      brightness == Brightness.dark ? darkBackground : lightBackground;
  static Color card(Brightness brightness) => brightness == Brightness.dark ? darkCard : lightCard;

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
