/// Traffic-light state for the Offline Intelligence status badge (Issue
/// #109) — mirrors [ShouldRefreshIntelligenceCache]'s own cadence so the
/// UI and the #105/#106 cache sync never disagree on freshness.
enum IntelligenceSyncState { syncing, localMode, updateRequired }
