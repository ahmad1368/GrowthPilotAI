import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/core/models/peer_benchmark_gap.dart';

/// Per-axis gap between the merchant and the Vancouver sector peer average
/// (Issue #363), reusing the already-computed [BusinessCompassMetrics]
/// (#84) and mocked sector benchmark (#83) rather than a new metrics
/// pipeline — no Anonymized Data Lake (#80) exists to source a real
/// per-peer comparison from.
class ComputePeerBenchmarkGaps {
  static List<PeerBenchmarkGap> call(
    BusinessCompassMetrics user,
    BusinessCompassMetrics benchmark,
  ) {
    final userValues = user.toList();
    final benchmarkValues = benchmark.toList();

    return [
      for (var i = 0; i < userValues.length; i++)
        PeerBenchmarkGap(
          metricLabel: BusinessCompassMetrics.labels[i],
          userValue: userValues[i],
          benchmarkValue: benchmarkValues[i],
          gap: userValues[i] - benchmarkValues[i],
          isAboveBenchmark: userValues[i] >= benchmarkValues[i],
        ),
    ];
  }
}
