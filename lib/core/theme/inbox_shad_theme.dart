import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flat, minimal ShadTheme for the Inbox screen (Issue #72) — no
/// glassmorphism/BackdropFilter despite the original issue's literal ask,
/// matching GrowthPilotAI's fixed palette: dark bg #09090b / card #18181b,
/// light bg/card #ffffff + soft shadow.
class InboxShadTheme {
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
