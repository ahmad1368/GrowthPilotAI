import 'package:growth_pilot_ai/core/enum/efficiency_gap_status.dart';

/// Buckets an Efficiency Gap score into a deal-quality status, mirroring
/// the issue's own `getStatus` thresholds (Issue #100).
class ClassifyEfficiencyGap {
  static EfficiencyGapStatus call(int score) {
    if (score > 80) return EfficiencyGapStatus.excellentDeal;
    if (score > 50) return EfficiencyGapStatus.fairValue;
    return EfficiencyGapStatus.belowAverage;
  }
}
