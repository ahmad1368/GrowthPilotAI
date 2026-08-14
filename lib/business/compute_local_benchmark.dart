import 'package:growth_pilot_ai/business/compute_percentile_rank.dart';
import 'package:growth_pilot_ai/core/models/local_benchmark_params.dart';
import 'package:growth_pilot_ai/core/models/local_benchmark_result.dart';
import 'package:growth_pilot_ai/core/utils/anomaly_detector.dart';

/// The on-device "mini-server" statistical core (Issue #107 scope item
/// 2) — reuses #96's [ComputePercentileRank] and #98's
/// [AnomalyDetector.mean] rather than reimplementing them, matching the
/// issue's own percentile/marketMean pseudocode exactly. Pure and
/// side-effect-free, so it's the piece safe to run inside `compute()`'s
/// isolate — everything before this (decrypting #106's cache) must stay
/// on the root isolate, since `flutter_secure_storage`'s platform
/// channel isn't reachable from a background isolate.
class ComputeLocalBenchmark {
  static LocalBenchmarkResult call(LocalBenchmarkParams params) {
    final target = params.targetPricePosition;
    final peers = params.peerPricePositions;
    if (target == null || peers.isEmpty) {
      return LocalBenchmarkResult(percentile: null, marketMean: null, peerCount: peers.length);
    }
    return LocalBenchmarkResult(
      percentile: ComputePercentileRank.call(target, peers),
      marketMean: AnomalyDetector.mean(peers),
      peerCount: peers.length,
    );
  }
}
