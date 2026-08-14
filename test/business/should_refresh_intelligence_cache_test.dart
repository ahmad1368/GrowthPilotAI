import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_refresh_intelligence_cache.dart';

void main() {
  group('ShouldRefreshIntelligenceCache', () {
    final now = DateTime(2026, 8, 13, 12);

    test('refreshes when no prior sync has ever happened', () {
      expect(ShouldRefreshIntelligenceCache.call(null, now), isTrue);
    });

    test('does not refresh before the 6-hour interval has elapsed', () {
      final lastSyncedAt = now.subtract(const Duration(hours: 5));
      expect(ShouldRefreshIntelligenceCache.call(lastSyncedAt, now), isFalse);
    });

    test('refreshes once the 6-hour interval has elapsed', () {
      final lastSyncedAt = now.subtract(const Duration(hours: 6));
      expect(ShouldRefreshIntelligenceCache.call(lastSyncedAt, now), isTrue);
    });
  });
}
