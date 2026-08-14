import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_intelligence_cache_checksum.dart';

void main() {
  group('ComputeIntelligenceCacheChecksum', () {
    final syncedAt = DateTime(2026, 8, 13);

    test('is deterministic for identical inputs', () {
      final a = ComputeIntelligenceCacheChecksum.call(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        encryptedSnapshot: 'iv:cipher',
        syncedAt: syncedAt,
      );
      final b = ComputeIntelligenceCacheChecksum.call(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        encryptedSnapshot: 'iv:cipher',
        syncedAt: syncedAt,
      );
      expect(a, b);
    });

    test('changes when the ciphertext changes', () {
      final a = ComputeIntelligenceCacheChecksum.call(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        encryptedSnapshot: 'iv:cipher-1',
        syncedAt: syncedAt,
      );
      final b = ComputeIntelligenceCacheChecksum.call(
        itemId: 'item-1',
        sectorId: 'AUTOMOTIVE',
        encryptedSnapshot: 'iv:cipher-2',
        syncedAt: syncedAt,
      );
      expect(a, isNot(b));
    });
  });
}
