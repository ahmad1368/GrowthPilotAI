/// Whether a shadow record's TTL has passed (Issue #94) — mirrors
/// [IsSessionTokenExpired]'s shape.
class IsAnalyticsRecordExpired {
  static bool call(DateTime expireAt, DateTime now) => now.isAfter(expireAt);
}
