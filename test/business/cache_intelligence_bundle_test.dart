import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/cache_intelligence_bundle.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';
import 'package:growth_pilot_ai/core/models/intelligence_bundle.dart';

void main() {
  group('CacheIntelligenceBundle', () {
    const bundle = IntelligenceBundle(
      sector: 'ELECTRONICS',
      radarAxisLabels: ['Warranty', 'Battery'],
      context: DistilledContext(
        marketTemperature: MarketTemperature.hot,
        pricePosition: 0.1,
        scarcityIndex: 0.4,
        isHiddenGem: true,
      ),
      highlights: ['Hidden gem'],
    );

    test('maps the bundle fields onto a cache row for the given item', () {
      final syncedAt = DateTime(2026, 8, 13);
      final entry = CacheIntelligenceBundle.call('item-42', bundle, syncedAt);

      expect(entry.itemId, 'item-42');
      expect(entry.sectorId, 'ELECTRONICS');
      expect(entry.marketTemperatureIndex, MarketTemperature.hot.index);
      expect(entry.pricePosition, 0.1);
      expect(entry.scarcityIndex, 0.4);
      expect(entry.isHiddenGem, isTrue);
      expect(entry.syncedAt, syncedAt);
    });

    test('preserves an existing row id so the caller can update in place', () {
      final entry = CacheIntelligenceBundle.call('item-42', bundle, DateTime(2026, 8, 13), id: 7);
      expect(entry.id, 7);
    });
  });
}
