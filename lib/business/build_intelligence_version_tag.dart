import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

/// Short, privacy-safe "version" tag for the Offline Intelligence badge
/// (Issue #109 AC: "specific version of the Sector Intelligence Bundle")
/// — sector + an 8-char content-hash prefix, never the raw DB row or full
/// hash (AC: "Privacy Integrity").
class BuildIntelligenceVersionTag {
  static String? call(List<IntelligenceCacheEntryEntity> entries) {
    if (entries.isEmpty) return null;
    final latest = entries.reduce((a, b) => a.syncedAt.isAfter(b.syncedAt) ? a : b);
    return '${latest.sectorId}-${latest.contentHash.substring(0, 8)}';
  }
}
