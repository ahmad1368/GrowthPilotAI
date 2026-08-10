import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_radar_polygon_points.dart';
import 'package:growth_pilot_ai/core/models/chart_data_point.dart';

void main() {
  test('an empty axis list produces no points', () {
    expect(ComputeRadarPolygonPoints.call(const [], 100), isEmpty);
  });

  test('a zero-value axis places its point at the center', () {
    final points = ComputeRadarPolygonPoints.call(
        const [ChartDataPoint(label: 'x', value: 0)], 100);
    expect(points.single.dx, 0);
    expect(points.single.dy, 0);
  });

  test('four full-value axes form a diamond starting from the top', () {
    final axes = List.generate(4, (_) => const ChartDataPoint(label: 'x', value: 100));
    final points = ComputeRadarPolygonPoints.call(axes, 100);

    expect(points.length, 4);
    // Top
    expect(points[0].dx, closeTo(0, 1e-9));
    expect(points[0].dy, closeTo(-100, 1e-9));
    // Right
    expect(points[1].dx, closeTo(100, 1e-9));
    expect(points[1].dy, closeTo(0, 1e-9));
    // Bottom
    expect(points[2].dx, closeTo(0, 1e-9));
    expect(points[2].dy, closeTo(100, 1e-9));
    // Left
    expect(points[3].dx, closeTo(-100, 1e-9));
    expect(points[3].dy, closeTo(0, 1e-9));
  });

  test('a half-value axis scales its point halfway to the edge', () {
    final points = ComputeRadarPolygonPoints.call(
        const [ChartDataPoint(label: 'x', value: 50)], 100);
    // Single axis starts at the top: (0, -radius * 0.5).
    expect(points.single.dx, closeTo(0, 1e-9));
    expect(points.single.dy, closeTo(-50, 1e-9));
  });

  test('values above 100 are clamped', () {
    final points = ComputeRadarPolygonPoints.call(
        const [ChartDataPoint(label: 'x', value: 150)], 100);
    expect(points.single.dy, closeTo(-100, 1e-9));
  });
}
