import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flat, minimal ShadTheme for the Category Mapping screen (Issue #58) —
/// no glassmorphism/BackdropFilter, matching GrowthPilotAI's fixed palette:
/// dark bg #09090b / card #18181b, light bg/card #ffffff + soft shadow.
class MappingShadTheme {
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
