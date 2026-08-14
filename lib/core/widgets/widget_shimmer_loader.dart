import 'package:flutter/material.dart';

/// Flat placeholder [LazyWidgetWrapper] shows before a report widget has
/// first scrolled into view (Issue #119) — a plain card-shaped block, not
/// the issue's literal shimmer-gradient ask, to stay flat/minimal per the
/// current design system. Deliberately unanimated: this gets embedded in
/// every grid tile before it's proven visible, and any `flutter_animate`
/// controller (even a one-shot fade) leaves a startup Timer that widget
/// tests flag as still-pending at teardown.
class WidgetShimmerLoader extends StatelessWidget {
  final double height;

  const WidgetShimmerLoader({super.key, this.height = 160});

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: fg.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
