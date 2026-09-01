import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_intelligence_version_tag.dart';
import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

void main() {
  group('BuildIntelligenceVersionTag', () {
    test('returns null when the cache is empty', () {
      expect(BuildIntelligenceVersionTag.call([]), isNull);
    });

    test('tags with the most-recently-synced entry, not just the first one', () {
      final older = IntelligenceCacheEntryEntity(
        itemId: 'a',
        sectorId: 'retail',
        contentHash: 'aaaaaaaaaaaaaaaa',
        encryptedSnapshot: 'x',
        checksum: 'x',
        syncedAt: DateTime(2026, 8, 1),
      );
      final newer = IntelligenceCacheEntryEntity(
        itemId: 'b',
        sectorId: 'construction',
        contentHash: 'bbbbbbbbbbbbbbbb',
        encryptedSnapshot: 'x',
        checksum: 'x',
        syncedAt: DateTime(2026, 8, 10),
      );
      final result = BuildIntelligenceVersionTag.call([older, newer]);
      expect(result, 'construction-bbbbbbbb');
    });

    test('never leaks the full content hash, only an 8-char prefix', () {
      final entry = IntelligenceCacheEntryEntity(
        itemId: 'a',
        sectorId: 'retail',
        contentHash: 'aaaaaaaaaaaaaaaaaaaaaaaa',
        encryptedSnapshot: 'x',
        checksum: 'x',
        syncedAt: DateTime(2026, 8, 1),
      );
      final result = BuildIntelligenceVersionTag.call([entry]);
      expect(result, isNot(contains(entry.contentHash)));
      expect(result, 'retail-aaaaaaaa');
    });
  });
}
