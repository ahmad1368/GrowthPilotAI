import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_intelligence_cache_checksum.dart';
import 'package:growth_pilot_ai/business/verify_intelligence_cache_integrity.dart';
import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

void main() {
  group('VerifyIntelligenceCacheIntegrity', () {
    test('passes for an entry whose checksum matches its stored fields', () {
      final syncedAt = DateTime(2026, 8, 13);
      final checksum = ComputeIntelligenceCacheChecksum.call(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        encryptedSnapshot: 'iv:cipher',
        syncedAt: syncedAt,
      );
      final entry = IntelligenceCacheEntryEntity(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        contentHash: 'hash-1',
        encryptedSnapshot: 'iv:cipher',
        checksum: checksum,
        syncedAt: syncedAt,
      );

      expect(VerifyIntelligenceCacheIntegrity.call(entry), isTrue);
    });

    test('fails when the ciphertext was altered after the checksum was written', () {
      final syncedAt = DateTime(2026, 8, 13);
      final entry = IntelligenceCacheEntryEntity(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        contentHash: 'hash-1',
        encryptedSnapshot: 'iv:tampered-cipher',
        checksum: ComputeIntelligenceCacheChecksum.call(
          itemId: 'item-1',
          sectorId: 'AUTOMOTIVE',
          encryptedSnapshot: 'iv:original-cipher',
          syncedAt: syncedAt,
        ),
        syncedAt: syncedAt,
      );

      expect(VerifyIntelligenceCacheIntegrity.call(entry), isFalse);
    });
  });
}
