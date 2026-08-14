import 'package:growth_pilot_ai/business/should_refresh_intelligence_cache.dart';
import 'package:growth_pilot_ai/core/enum/intelligence_sync_state.dart';

/// Derives the Offline Intelligence status badge state (Issue #109) from
/// the same freshness cadence [IntelligenceCacheSyncService] already uses
/// (Issue #105's 6-hour interval), so the badge never claims "Local Intel"
/// is fresh when a sync is actually overdue.
class DetermineIntelligenceSyncState {
  static IntelligenceSyncState call({
    required bool isSyncing,
    required DateTime? lastSyncedAt,
    required DateTime now,
  }) {
    if (isSyncing) return IntelligenceSyncState.syncing;
    return ShouldRefreshIntelligenceCache.call(lastSyncedAt, now)
        ? IntelligenceSyncState.updateRequired
        : IntelligenceSyncState.localMode;
  }
}
