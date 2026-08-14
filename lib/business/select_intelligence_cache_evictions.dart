import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

/// "500 most relevant items" storage cap (Issue #105 AC: the local store
/// stays within its size budget) — keeps the most recently synced
/// entries and returns the rest for eviction.
class SelectIntelligenceCacheEvictions {
  static const maxEntries = 500;

  static List<IntelligenceCacheEntryEntity> call(List<IntelligenceCacheEntryEntity> cached) {
    if (cached.length <= maxEntries) return const [];
    final sorted = [...cached]..sort((a, b) => b.syncedAt.compareTo(a.syncedAt));
    return sorted.sublist(maxEntries);
  }
}
