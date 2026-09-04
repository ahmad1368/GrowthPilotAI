import 'package:flutter/material.dart';
import 'app_design_tokens.dart';
import 'background_pattern_painter.dart';

/// [Issue #784] Branded background — a subtle, low-opacity tiled pattern
/// of receipt/growth/finance icons behind [child], in the spirit of
/// WhatsApp's doodle wallpaper but themed to GrowthPilotAI's own domain.
/// Flat (no BackdropFilter/blur) and theme-aware: opacity/tint follow
/// [AppDesignTokens] per light/dark mode.
class AppBackgroundPattern extends StatelessWidget {
  final Widget child;

  const AppBackgroundPattern({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: AppDesignTokens.background(brightness),
            child: CustomPaint(
              painter: BackgroundPatternPainter(
                // Dark surfaces need a lower alpha for the same perceived
                // subtlety, since the glyph color also sits closer in
                // luminance to the near-black background.
                color: AppDesignTokens.primary(brightness)
                    .withValues(alpha: isDark ? 0.05 : 0.06),
              ),
              size: Size.infinite,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
