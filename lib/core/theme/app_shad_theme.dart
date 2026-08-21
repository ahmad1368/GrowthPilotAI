import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

/// The single canonical ShadTheme (Issue #1) for every screen that opts
/// into shadcn_ui — flat, no glassmorphism/BackdropFilter, matching
/// GrowthPilotAI's fixed palette: dark bg #09090b / card #18181b, light
/// bg/card #ffffff. Replaces the former per-screen `InboxShadTheme` and
/// `MappingShadTheme`, which were identical copies of this same theme.
/// Card color now sourced from [AppDesignTokens] (Issue #175) instead
/// of its own hex literal.
class AppShadTheme {
  static ShadThemeData build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ShadThemeData(
      brightness: brightness,
      colorScheme: isDark
          ? const ShadZincColorScheme.dark(card: AppDesignTokens.darkCard)
          : const ShadZincColorScheme.light(),
    );
  }
}
