/// Input for [ComputeLocalBenchmark.call] — plain data so it can safely
/// cross the `compute()` isolate boundary (Issue #107 scope item 4:
/// "Isolate-based Processing").
class LocalBenchmarkParams {
  final double? targetPricePosition;
  final List<double> peerPricePositions;

  const LocalBenchmarkParams({
    required this.targetPricePosition,
    required this.peerPricePositions,
  });
}
