import 'package:growth_pilot_ai/business/build_intelligence_cache_snapshot_json.dart';
import 'package:growth_pilot_ai/business/compute_intelligence_cache_checksum.dart';
import 'package:growth_pilot_ai/business/compute_intelligence_cache_content_hash.dart';
import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';
import 'package:growth_pilot_ai/core/models/intelligence_bundle.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// Turns one #104 [IntelligenceBundle] into the encrypted row the Edge
/// Downloader persists (Issue #105 scope item 2, encrypted at rest per
/// #106 — this app's existing ObjectBox store rather than adding a
/// second database engine) — [id] preserves an existing row's primary
/// key so [IntelligenceCacheRepository.upsert] updates in place instead
/// of duplicating rows.
class CacheIntelligenceBundle {
  static Future<IntelligenceCacheEntryEntity> call(
    String itemId,
    IntelligenceBundle bundle,
    DateTime syncedAt,
    FieldCipher cipher, {
    int id = 0,
  }) async {
    final snapshotJson = BuildIntelligenceCacheSnapshotJson.call(bundle.context);
    final encryptedSnapshot = await cipher.encryptField(snapshotJson);

    return IntelligenceCacheEntryEntity(
      id: id,
      itemId: itemId,
      sectorId: bundle.sector,
      contentHash: ComputeIntelligenceCacheContentHash.call(snapshotJson),
      encryptedSnapshot: encryptedSnapshot,
      checksum: ComputeIntelligenceCacheChecksum.call(
        itemId: itemId,
        sectorId: bundle.sector,
        encryptedSnapshot: encryptedSnapshot,
        syncedAt: syncedAt,
      ),
      syncedAt: syncedAt,
    );
  }
}
