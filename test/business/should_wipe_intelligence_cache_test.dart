import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_wipe_intelligence_cache.dart';

void main() {
  group('ShouldWipeIntelligenceCache', () {
    test('does not wipe below the threshold', () {
      expect(ShouldWipeIntelligenceCache.call(ShouldWipeIntelligenceCache.maxConsecutiveFailures - 1), isFalse);
    });

    test('wipes once the threshold is reached', () {
      expect(ShouldWipeIntelligenceCache.call(ShouldWipeIntelligenceCache.maxConsecutiveFailures), isTrue);
    });

    test('a single failure never triggers a wipe', () {
      expect(ShouldWipeIntelligenceCache.call(1), isFalse);
    });
  });
}
