import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';

/// "Delta-Update Logic" (Issue #105 scope item 3): only a changed entry
/// is worth writing back to the local store — avoids the unconditional
/// overwrite the issue's own `batchUpdate` pseudocode would otherwise do
/// on every sync tick, minimizing on-device I/O and data usage.
class HasIntelligenceCacheEntryChanged {
  static bool call(IntelligenceCacheEntryEntity? cached, IntelligenceCacheEntryEntity fresh) {
    if (cached == null) return true;
    return cached.sectorId != fresh.sectorId ||
        cached.marketTemperatureIndex != fresh.marketTemperatureIndex ||
        cached.pricePosition != fresh.pricePosition ||
        cached.scarcityIndex != fresh.scarcityIndex ||
        cached.isHiddenGem != fresh.isHiddenGem;
  }
}
