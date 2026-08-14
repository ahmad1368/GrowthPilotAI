import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_sector_axis_weights.dart';
import 'package:growth_pilot_ai/core/models/chart_data_point.dart';

void main() {
  group('ApplySectorAxisWeights', () {
    test('multiplies a weighted axis by its factor', () {
      const axes = [ChartDataPoint(label: 'Mileage', value: 20)];
      final weighted = ApplySectorAxisWeights.call(axes, {'Mileage': 3.0});
      expect(weighted.single.value, 60);
    });

    test('leaves an axis missing from the weight map at its original value', () {
      const axes = [ChartDataPoint(label: 'Safety', value: 40)];
      final weighted = ApplySectorAxisWeights.call(axes, {'Mileage': 3.0});
      expect(weighted.single.value, 40);
    });

    test('preserves axis order and labels', () {
      const axes = [
        ChartDataPoint(label: 'A', value: 10),
        ChartDataPoint(label: 'B', value: 20),
      ];
      final weighted = ApplySectorAxisWeights.call(axes, {});
      expect(weighted.map((a) => a.label).toList(), ['A', 'B']);
    });

    test('an empty axis list produces no output', () {
      expect(ApplySectorAxisWeights.call(const [], {'Mileage': 3.0}), isEmpty);
    });
  });
}
