/// "Cooldown" throttle (Issue #108 scope item 2, layered on top of #71's
/// generic 5-per-hour non-critical cap): at most one Market Insight
/// notification every 12 hours, however many high-value items a scan
/// finds.
class ShouldSendInsightNotification {
  static const cooldown = Duration(hours: 12);

  static bool call(DateTime? lastNotificationAt, DateTime now) =>
      lastNotificationAt == null || now.difference(lastNotificationAt) >= cooldown;
}
