import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/trend_direction.dart';

/// The up/down arrow for a [TrendDirection] (Issue #234) — split out of
/// `StatCard` to keep it under the 50-line guideline.
class TrendIcon extends StatelessWidget {
  final TrendDirection trend;

  const TrendIcon({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    switch (trend) {
      case TrendDirection.up:
        return const Icon(Icons.arrow_upward, color: Colors.green, size: 14);
      case TrendDirection.down:
        return const Icon(Icons.arrow_downward, color: Colors.red, size: 14);
      case TrendDirection.flat:
      case TrendDirection.none:
        return const SizedBox.shrink();
    }
  }
}
