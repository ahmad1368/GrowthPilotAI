/// Whether a session has been inactive long enough to be swept by a
/// cleanup job (Issue #173 AC: "Auto-Cleanup ... delete sessions that
/// haven't been active for 30+ days"). No cron exists client-side — this
/// is the pure predicate a future scheduled task would apply.
class IsSessionStale {
  static const staleAfter = Duration(days: 30);

  static bool call(DateTime lastActiveAt, DateTime now) =>
      now.difference(lastActiveAt) >= staleAfter;
}
