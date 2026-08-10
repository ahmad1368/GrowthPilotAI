import 'dart:math';
import 'dart:ui';

import 'package:growth_pilot_ai/core/models/chart_data_point.dart';

/// Pure geometry for a radar/spider chart (Issue #99): places each axis
/// evenly around a circle starting from the top, scaling its point
/// toward the center by `value/100` (values are percentiles, #96) —
/// [radius]-relative [Offset]s the painter draws around its own center.
class ComputeRadarPolygonPoints {
  static List<Offset> call(List<ChartDataPoint> axes, double radius) {
    final n = axes.length;
    if (n == 0) return const [];

    return List.generate(n, (i) {
      final angle = -pi / 2 + i * (2 * pi / n);
      final normalized = axes[i].value.clamp(0.0, 100.0) / 100.0;
      final r = radius * normalized;
      return Offset(r * cos(angle), r * sin(angle));
    });
  }
}
