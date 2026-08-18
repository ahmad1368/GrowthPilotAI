import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';

/// "risk_score: Aggregated score based on bottlenecks identified in
/// Issue 224" (Issue #233) — mean severity weight (low=10/medium=40/
/// high=80) across all detected [BottleneckInsight]s, on a `0-100`
/// scale.
class ComputeBottleneckRiskScore {
  static const _weights = {
    BottleneckSeverity.low: 10,
    BottleneckSeverity.medium: 40,
    BottleneckSeverity.high: 80,
  };

  static double call(List<BottleneckInsight> bottlenecks) {
    if (bottlenecks.isEmpty) return 0;
    final total = bottlenecks.fold<int>(0, (sum, b) => sum + (_weights[b.severity] ?? 0));
    return total / bottlenecks.length;
  }
}
