import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/scale_interval_for_performance_tier.dart';
import 'package:growth_pilot_ai/core/enum/performance_tier.dart';

void main() {
  group('ScaleIntervalForPerformanceTier', () {
    const base = Duration(hours: 6);

    test('doubles the interval on low-tier hardware', () {
      final result = ScaleIntervalForPerformanceTier.call(base, PerformanceTier.low);
      expect(result, const Duration(hours: 12));
    });

    test('leaves mid/high tier hardware at the base cadence', () {
      expect(ScaleIntervalForPerformanceTier.call(base, PerformanceTier.mid), base);
      expect(ScaleIntervalForPerformanceTier.call(base, PerformanceTier.high), base);
    });

    test('doubles the interval when Power Saver Mode is on, even on high tier', () {
      final result = ScaleIntervalForPerformanceTier.call(base, PerformanceTier.high,
          powerSaverEnabled: true);
      expect(result, const Duration(hours: 12));
    });
  });
}
