import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';

/// One computed snapshot of "project health" KPIs (Issue #233) — the
/// local stand-in for the issue's Postgres `project_metrics` table row,
/// computed on-demand client-side instead of via materialized views
/// (see PR notes).
@immutable
class ProjectMetricsSnapshot {
  final Map<RequirementType, int> requirementCounts;
  final double volatilityRate;
  final double riskScore;
  final double roiEstimate;
  final double complexityIndex;

  const ProjectMetricsSnapshot({
    required this.requirementCounts,
    required this.volatilityRate,
    required this.riskScore,
    required this.roiEstimate,
    required this.complexityIndex,
  });

  int get totalRequirements => requirementCounts.values.fold(0, (a, b) => a + b);
}
