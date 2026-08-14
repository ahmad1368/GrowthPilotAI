/// "Background Monitor Task" cadence (Issue #108 scope item 1): scans
/// every 3 hours, the midpoint of the issue's own "every 2-4 hours"
/// range — [lastScanAt] is null before the first scan has ever run.
class ShouldRunInsightScan {
  static const interval = Duration(hours: 3);

  static bool call(DateTime? lastScanAt, DateTime now) =>
      lastScanAt == null || now.difference(lastScanAt) >= interval;
}
