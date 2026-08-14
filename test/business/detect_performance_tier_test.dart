import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_performance_tier.dart';
import 'package:growth_pilot_ai/core/enum/performance_tier.dart';

void main() {
  group('DetectPerformanceTier', () {
    test('classifies fewer than 4 cores as low tier', () {
      expect(DetectPerformanceTier.call(2), PerformanceTier.low);
      expect(DetectPerformanceTier.call(3), PerformanceTier.low);
    });

    test('classifies 4 to 7 cores as mid tier', () {
      expect(DetectPerformanceTier.call(4), PerformanceTier.mid);
      expect(DetectPerformanceTier.call(7), PerformanceTier.mid);
    });

    test('classifies 8 or more cores as high tier', () {
      expect(DetectPerformanceTier.call(8), PerformanceTier.high);
      expect(DetectPerformanceTier.call(16), PerformanceTier.high);
    });
  });
}
