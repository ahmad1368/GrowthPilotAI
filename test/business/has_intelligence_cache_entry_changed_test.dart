import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/has_intelligence_cache_entry_changed.dart';
import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

IntelligenceCacheEntryEntity _entry({String sectorId = 'AUTOMOTIVE', String contentHash = 'hash-a'}) {
  return IntelligenceCacheEntryEntity(
    itemId: 'item-1',
    sectorId: sectorId,
    contentHash: contentHash,
    encryptedSnapshot: 'iv:cipher-1',
    checksum: 'checksum-1',
    syncedAt: DateTime(2026, 8, 13),
  );
}

void main() {
  group('HasIntelligenceCacheEntryChanged', () {
    test('is true when no cached entry exists yet', () {
      expect(HasIntelligenceCacheEntryChanged.call(null, _entry()), isTrue);
    });

    test('is false when the sector and content hash are identical', () {
      expect(HasIntelligenceCacheEntryChanged.call(_entry(), _entry()), isFalse);
    });

    test('is true when the content hash changed', () {
      expect(
        HasIntelligenceCacheEntryChanged.call(_entry(contentHash: 'hash-a'), _entry(contentHash: 'hash-b')),
        isTrue,
      );
    });

    test('is true when the sector changed', () {
      expect(
        HasIntelligenceCacheEntryChanged.call(_entry(sectorId: 'AUTOMOTIVE'), _entry(sectorId: 'ELECTRONICS')),
        isTrue,
      );
    });

    test('ignores ciphertext differing on its own — only the content hash matters', () {
      final cached = IntelligenceCacheEntryEntity(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        contentHash: 'hash-a',
        encryptedSnapshot: 'iv-1:cipher-1',
        checksum: 'checksum-1',
        syncedAt: DateTime(2026, 8, 13),
      );
      final fresh = IntelligenceCacheEntryEntity(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        contentHash: 'hash-a',
        encryptedSnapshot: 'iv-2:cipher-2',
        checksum: 'checksum-2',
        syncedAt: DateTime(2026, 8, 13),
      );
      expect(HasIntelligenceCacheEntryChanged.call(cached, fresh), isFalse);
    });
  });
}
