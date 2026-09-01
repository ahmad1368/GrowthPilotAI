import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_radar_polygon_points.dart';
import 'package:growth_pilot_ai/core/models/chart_data_point.dart';
import 'package:growth_pilot_ai/features/insights/widgets/draw_radar_grid_rings.dart';

/// Draws the grid rings and filled data polygon for [RadarComparisonChart]
/// (Issue #99) — flat fill/stroke, no blur/glow (architecture forbids
/// Glassmorphism/BackdropFilter).
class RadarChartPainter extends CustomPainter {
  final List<ChartDataPoint> axes;
  final Color gridColor;
  final Color fillColor;
  final Color strokeColor;

  RadarChartPainter({
    required this.axes,
    required this.gridColor,
    required this.fillColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (axes.isEmpty) return;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2 * 0.8;

    drawRadarGridRings(canvas, axes.length, center, radius, Paint()
      ..style = PaintingStyle.stroke
      ..color = gridColor);

    final dataPoints =
        ComputeRadarPolygonPoints.call(axes, radius).map((p) => p + center).toList();
    final dataPath = Path()..addPolygon(dataPoints, true);
    canvas.drawPath(dataPath, Paint()..color = fillColor.withValues(alpha: 0.4));
    canvas.drawPath(
        dataPath,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = strokeColor);
  }

  @override
  bool shouldRepaint(covariant RadarChartPainter oldDelegate) => oldDelegate.axes != axes;
}
