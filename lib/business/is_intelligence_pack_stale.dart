/// "Kill Switch" (Issue #86 Security note): a pack becomes invalid if it
/// hasn't been updated in 30 days, forcing a re-sync rather than trusting
/// stale Metro Vancouver market data.
class IsIntelligencePackStale {
  static const maxAge = Duration(days: 30);

  static bool call(DateTime lastSyncedAt, DateTime now) =>
      now.difference(lastSyncedAt) >= maxAge;
}
