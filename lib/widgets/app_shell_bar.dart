import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

/// Scroll-adaptive app bar (Issue #6): fades from transparent to the flat
/// theme surface color as [opacity] rises with scroll offset (see
/// [HomeLogic.appBarOpacity]). Replaces the Glassmorphism-era GlassAppBar/
/// DynamicAppBar — no BackdropFilter/blur per the current design system.
class AppShellBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double opacity;
  final List<Widget>? actions;

  const AppShellBar({
    super.key,
    required this.title,
    required this.opacity,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final surface = AppDesignTokens.background(brightness);
    final foreground = isDark ? Colors.white : Colors.black;

    return AppBar(
      elevation: 0,
      backgroundColor: Color.lerp(surface.withValues(alpha: 0), surface, opacity),
      iconTheme: IconThemeData(color: foreground),
      // Issue #6 AC: status bar icons must stay legible across the fade —
      // matches the app bar's own foreground, not the fading background.
      systemOverlayStyle:
          isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, color: foreground)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
