import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/chart_axis_mapping.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/mapped_radar_report_widget.dart';

/// Proves Issue #112's acceptance criterion: the same [MappedRadarReportWidget]
/// class renders entirely different axes for two unrelated categories, driven
/// only by the `mapping`/`raw` data it's given. fl_chart draws radar titles
/// on a canvas rather than as `Text` widgets, so this reads the resulting
/// [RadarChartData] instead of using `find.text`.
void main() {
  Future<RadarChartData> pump(
      WidgetTester tester, Map<String, dynamic> data) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: MappedRadarReportWidget(data: data, title: 'Comparison'),
        ),
      ),
    ));
    return tester.widget<RadarChart>(find.byType(RadarChart)).data;
  }

  List<String> labelsOf(RadarChartData data, int count) =>
      List.generate(count, (i) => data.getTitle!(i, 0).text);

  testWidgets('renders phone axes for a phone payload', (tester) async {
    final data = await pump(tester, {
      'raw': {'battery': 60, 'screen': 80, 'speed': 70},
      'mapping': const [
        ChartAxisMapping(key: 'battery', label: 'Battery'),
        ChartAxisMapping(key: 'screen', label: 'Screen'),
        ChartAxisMapping(key: 'speed', label: 'Speed'),
      ],
    });

    expect(labelsOf(data, 3), ['Battery', 'Screen', 'Speed']);
    expect(data.dataSets.single.dataEntries.map((e) => e.value),
        [60.0, 80.0, 70.0]);
  });

  testWidgets('renders car axes for a car payload with no code changes',
      (tester) async {
    final data = await pump(tester, {
      'raw': {
        'price_percentile': 85,
        'km_percentile': 40,
        'safety_score': 90
      },
      'mapping': const [
        ChartAxisMapping(key: 'price_percentile', label: 'Value'),
        ChartAxisMapping(key: 'km_percentile', label: 'Usage'),
        ChartAxisMapping(key: 'safety_score', label: 'Safety'),
      ],
    });

    expect(labelsOf(data, 3), ['Value', 'Usage', 'Safety']);
    expect(data.dataSets.single.dataEntries.map((e) => e.value),
        [85.0, 40.0, 90.0]);
  });
}
