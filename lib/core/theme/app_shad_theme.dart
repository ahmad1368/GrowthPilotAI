import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

/// The single canonical ShadTheme (Issue #1) for every screen that opts
/// into shadcn_ui — flat, no glassmorphism/BackdropFilter, matching
/// GrowthPilotAI's warm palette (Issue #784). Replaces the former
/// per-screen `InboxShadTheme` and `MappingShadTheme`, which were
/// identical copies of this same theme. Card color sourced from
/// [AppDesignTokens] (Issue #175) instead of its own hex literal.
///
/// [Issue #784] Switched from the cool `ShadZincColorScheme` to
/// `ShadOrangeColorScheme` — its own default primary already matches
/// [AppDesignTokens.primary] exactly per mode, so every shadcn_ui widget
/// across the app (buttons, inputs, cards — 350+ files) picks up the warm
/// palette automatically, not just the screens this issue touches directly.
class AppShadTheme {
  static ShadThemeData build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ShadThemeData(
      brightness: brightness,
      colorScheme: isDark
          ? const ShadOrangeColorScheme.dark(card: AppDesignTokens.darkCard)
          : const ShadOrangeColorScheme.light(card: AppDesignTokens.lightCard),
    );
  }
}
