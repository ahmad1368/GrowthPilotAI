/// "Automated background worker to scan for breached inventory
/// thresholds" (Issue #440 AC 2) cadence — scans every 6 hours, mirroring
/// [ShouldRunInsightScan]'s throttle-gated shape since this app has no
/// true OS-level background execution to schedule against.
/// [lastScanAt] is null before the first scan has ever run.
class ShouldRunLowStockScan {
  static const interval = Duration(hours: 6);

  static bool call(DateTime? lastScanAt, DateTime now) =>
      lastScanAt == null || now.difference(lastScanAt) >= interval;
}
