import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/churn_cohort_point.dart';

/// Retention KPI comparing the current lookback window to the one before
/// it (Issue #357), plus the trailing weekly cohort trend.
@immutable
class ChurnRetentionSnapshot {
  final int currentPeriodCount;
  final int previousPeriodCount;
  final double retentionRate;
  final bool isChurnRisk;
  final List<ChurnCohortPoint> cohortPoints;

  const ChurnRetentionSnapshot({
    required this.currentPeriodCount,
    required this.previousPeriodCount,
    required this.retentionRate,
    required this.isChurnRisk,
    required this.cohortPoints,
  });
}
