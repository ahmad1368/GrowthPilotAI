/// One on-device "Live Comparison" result (Issue #107) — [percentile]
/// mirrors #96's percentile rank against the locally cached peers in
/// the requested sector; both fields are null when there weren't enough
/// peers to benchmark against (AC: "Privacy Integrity" — nothing about
/// an individual peer is ever exposed, only this aggregate).
class LocalBenchmarkResult {
  final int? percentile;
  final double? marketMean;
  final int peerCount;

  const LocalBenchmarkResult({
    required this.percentile,
    required this.marketMean,
    required this.peerCount,
  });
}
