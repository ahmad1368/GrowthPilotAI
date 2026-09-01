import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/map_raw_data_to_chart_points.dart';
import 'package:growth_pilot_ai/core/models/chart_axis_mapping.dart';

void main() {
  test('maps raw keys to labeled points in mapping order', () {
    final points = MapRawDataToChartPoints.call(
      {'price_percentile': 85, 'km_percentile': 40, 'safety_score': 90},
      const [
        ChartAxisMapping(key: 'price_percentile', label: 'Value'),
        ChartAxisMapping(key: 'km_percentile', label: 'Usage'),
        ChartAxisMapping(key: 'safety_score', label: 'Safety'),
      ],
    );

    expect(points.map((p) => p.label).toList(), ['Value', 'Usage', 'Safety']);
    expect(points.map((p) => p.value).toList(), [85.0, 40.0, 90.0]);
  });

  test('the same mapper produces different axes for a different category', () {
    const carMapping = [
      ChartAxisMapping(key: 'price_percentile', label: 'Value'),
      ChartAxisMapping(key: 'km_percentile', label: 'Usage'),
    ];
    const phoneMapping = [
      ChartAxisMapping(key: 'battery', label: 'Battery'),
      ChartAxisMapping(key: 'screen', label: 'Screen'),
    ];

    final car = MapRawDataToChartPoints.call(
        {'price_percentile': 70, 'km_percentile': 30}, carMapping);
    final phone = MapRawDataToChartPoints.call(
        {'battery': 60, 'screen': 80}, phoneMapping);

    expect(car.map((p) => p.label), ['Value', 'Usage']);
    expect(phone.map((p) => p.label), ['Battery', 'Screen']);
  });

  test('a missing key defaults to 0.0 instead of throwing', () {
    final points = MapRawDataToChartPoints.call(
      {'safety_score': 90},
      const [ChartAxisMapping(key: 'price_percentile', label: 'Value')],
    );

    expect(points.single.value, 0.0);
  });

  test('a non-numeric value defaults to 0.0 instead of throwing', () {
    final points = MapRawDataToChartPoints.call(
      {'price_percentile': 'not-a-number'},
      const [ChartAxisMapping(key: 'price_percentile', label: 'Value')],
    );

    expect(points.single.value, 0.0);
  });
}
