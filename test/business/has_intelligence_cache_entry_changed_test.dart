import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/has_intelligence_cache_entry_changed.dart';
import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

IntelligenceCacheEntryEntity _entry({double? pricePosition = 0.5}) {
  return IntelligenceCacheEntryEntity(
    itemId: 'item-1',
    sectorId: 'AUTOMOTIVE',
    marketTemperatureIndex: 1,
    pricePosition: pricePosition,
    scarcityIndex: 0.2,
    isHiddenGem: false,
    syncedAt: DateTime(2026, 8, 13),
  );
}

void main() {
  group('HasIntelligenceCacheEntryChanged', () {
    test('is true when no cached entry exists yet', () {
      expect(HasIntelligenceCacheEntryChanged.call(null, _entry()), isTrue);
    });

    test('is false when every distilled field is identical', () {
      expect(HasIntelligenceCacheEntryChanged.call(_entry(), _entry()), isFalse);
    });

    test('is true when the price position changed', () {
      expect(
        HasIntelligenceCacheEntryChanged.call(_entry(pricePosition: 0.5), _entry(pricePosition: 0.9)),
        isTrue,
      );
    });

    test('is true when a null price position became available', () {
      expect(
        HasIntelligenceCacheEntryChanged.call(_entry(pricePosition: null), _entry(pricePosition: 0.5)),
        isTrue,
      );
    });
  });
}
