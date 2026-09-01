/// "Background Sync Engine" cadence (Issue #105 scope item 1): refresh
/// only once every 6 hours, mirroring the issue's own WorkManager /
/// BackgroundFetch interval — [lastSyncedAt] is null before the first
/// sync has ever run. [interval] can be overridden (Issue #110's
/// [ScaleIntervalForPerformanceTier]) to sync less often on low-end
/// hardware or in Power Saver Mode.
class ShouldRefreshIntelligenceCache {
  static const interval = Duration(hours: 6);

  static bool call(DateTime? lastSyncedAt, DateTime now, {Duration? interval}) =>
      lastSyncedAt == null ||
      now.difference(lastSyncedAt) >= (interval ?? ShouldRefreshIntelligenceCache.interval);
}
