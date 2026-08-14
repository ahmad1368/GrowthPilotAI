import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/select_intelligence_cache_evictions.dart';
import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

IntelligenceCacheEntryEntity _entryAt(int id, DateTime syncedAt) {
  return IntelligenceCacheEntryEntity(
    id: id,
    itemId: 'item-$id',
    sectorId: 'DEFAULT',
    contentHash: 'hash-$id',
    encryptedSnapshot: 'iv:cipher-$id',
    checksum: 'checksum-$id',
    syncedAt: syncedAt,
  );
}

void main() {
  group('SelectIntelligenceCacheEvictions', () {
    test('evicts nothing when under the cap', () {
      final cached = [_entryAt(1, DateTime(2026, 8, 1))];
      expect(SelectIntelligenceCacheEvictions.call(cached), isEmpty);
    });

    test('evicts the oldest entries once over the cap', () {
      final base = DateTime(2026, 1, 1);
      final cached = List.generate(
        SelectIntelligenceCacheEvictions.maxEntries + 3,
        (i) => _entryAt(i, base.add(Duration(days: i))),
      );

      final evicted = SelectIntelligenceCacheEvictions.call(cached);

      expect(evicted.length, 3);
      expect(evicted.map((e) => e.id), containsAll([0, 1, 2]));
    });

    test('never evicts more than needed to reach the cap', () {
      final base = DateTime(2026, 1, 1);
      final cached = List.generate(
        SelectIntelligenceCacheEvictions.maxEntries + 1,
        (i) => _entryAt(i, base.add(Duration(days: i))),
      );

      final evicted = SelectIntelligenceCacheEvictions.call(cached);
      expect(evicted.length, 1);
    });
  });
}
