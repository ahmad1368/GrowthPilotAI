import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';
import 'package:growth_pilot_ai/core/models/intelligence_bundle.dart';

/// Turns one #104 [IntelligenceBundle] into the row the Edge Downloader
/// persists (Issue #105 scope item 2: "SQLite/Drift Integration", built
/// on this app's existing ObjectBox store rather than adding a second
/// database engine) — [id] preserves an existing row's primary key so
/// [IntelligenceCacheRepository.upsert] updates in place instead of
/// duplicating rows.
class CacheIntelligenceBundle {
  static IntelligenceCacheEntryEntity call(
    String itemId,
    IntelligenceBundle bundle,
    DateTime syncedAt, {
    int id = 0,
  }) {
    final context = bundle.context;
    return IntelligenceCacheEntryEntity(
      id: id,
      itemId: itemId,
      sectorId: bundle.sector,
      marketTemperatureIndex: context.marketTemperature.index,
      pricePosition: context.pricePosition,
      scarcityIndex: context.scarcityIndex,
      isHiddenGem: context.isHiddenGem,
      syncedAt: syncedAt,
    );
  }
}
