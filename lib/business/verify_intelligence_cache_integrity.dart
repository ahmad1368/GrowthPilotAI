import 'package:growth_pilot_ai/business/compute_intelligence_cache_checksum.dart';
import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

/// Recomputes one cache row's checksum and compares it to the stored
/// value (Issue #106 AC) — a mismatch means the row was altered after
/// it was written, since this is the same canonical hash
/// [CacheIntelligenceBundle] computed at write time.
class VerifyIntelligenceCacheIntegrity {
  static bool call(IntelligenceCacheEntryEntity entry) {
    final recomputed = ComputeIntelligenceCacheChecksum.call(
      itemId: entry.itemId,
      sectorId: entry.sectorId,
      encryptedSnapshot: entry.encryptedSnapshot,
      syncedAt: entry.syncedAt,
    );
    return recomputed == entry.checksum;
  }
}
