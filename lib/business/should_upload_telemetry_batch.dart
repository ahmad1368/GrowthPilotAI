/// "Batch-upload every 48 hours" (Issue #87 scope item 1: "Privacy
/// Buffer") — instead of sending events instantly, which would let a
/// server observe user behavior in real time.
class ShouldUploadTelemetryBatch {
  static const batchInterval = Duration(hours: 48);

  static bool call(DateTime? lastUploadAt, DateTime now) =>
      lastUploadAt == null || now.difference(lastUploadAt) >= batchInterval;
}
