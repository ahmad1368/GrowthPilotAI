import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_radar_polygon_points.dart';
import 'package:growth_pilot_ai/core/models/chart_data_point.dart';

/// Draws the 25/50/75/100% background rings behind [RadarChartPainter]'s
/// data polygon, split out to keep that file under the SRP line budget.
void drawRadarGridRings(
  Canvas canvas,
  int axisCount,
  Offset center,
  double radius,
  Paint gridPaint,
) {
  final ringAxes =
      List.generate(axisCount, (_) => const ChartDataPoint(label: '', value: 100));
  for (final ringPercent in const [0.25, 0.5, 0.75, 1.0]) {
    final points = ComputeRadarPolygonPoints.call(ringAxes, radius * ringPercent)
        .map((p) => p + center)
        .toList();
    canvas.drawPath(Path()..addPolygon(points, true), gridPaint);
  }
}
