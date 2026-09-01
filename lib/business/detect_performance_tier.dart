import 'package:growth_pilot_ai/core/enum/performance_tier.dart';

/// Classifies the device's [PerformanceTier] from its CPU core count
/// (Issue #110 AC: "Privacy Integrity — only hardware specs are
/// analyzed", never PII). Mirrors the issue's own "RAM < 3000 or cores <
/// 4 -> low-end" heuristic, using cores only since core count is the one
/// signal available on every platform (including web) without a native
/// plugin.
class DetectPerformanceTier {
  static PerformanceTier call(int processorCount) {
    if (processorCount < 4) return PerformanceTier.low;
    if (processorCount < 8) return PerformanceTier.mid;
    return PerformanceTier.high;
  }
}
