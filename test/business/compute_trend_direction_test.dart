import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_trend_direction.dart';
import 'package:growth_pilot_ai/core/enum/trend_direction.dart';

void main() {
  group('ComputeTrendDirection', () {
    test('returns none when there is no previous value', () {
      expect(ComputeTrendDirection.call(null, 0.5), TrendDirection.none);
    });

    test('returns up when the value increased', () {
      expect(ComputeTrendDirection.call(0.2, 0.5), TrendDirection.up);
    });

    test('returns down when the value decreased', () {
      expect(ComputeTrendDirection.call(0.8, 0.5), TrendDirection.down);
    });

    test('returns flat when the value is unchanged', () {
      expect(ComputeTrendDirection.call(0.5, 0.5), TrendDirection.flat);
    });
  });
}
