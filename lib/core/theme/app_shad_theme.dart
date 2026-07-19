import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The single canonical ShadTheme (Issue #1) for every screen that opts
/// into shadcn_ui — flat, no glassmorphism/BackdropFilter, matching
/// GrowthPilotAI's fixed palette: dark bg #09090b / card #18181b, light
/// bg/card #ffffff. Replaces the former per-screen `InboxShadTheme` and
/// `MappingShadTheme`, which were identical copies of this same theme.
class AppShadTheme {
  static ShadThemeData build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ShadThemeData(
      brightness: brightness,
      colorScheme: isDark
          ? const ShadZincColorScheme.dark(card: Color(0xFF18181B))
          : const ShadZincColorScheme.light(),
    );
  }
}
