import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/project_health_grade.dart';

/// One computed snapshot of "project health" KPIs (Issue #233/#236) —
/// the local stand-in for the issue's Postgres `project_metrics` table
/// row, computed on-demand client-side instead of via materialized
/// views (see PR notes).
@immutable
class ProjectMetricsSnapshot {
  final Map<RequirementType, int> requirementCounts;
  final double volatilityRate;
  final double riskScore;
  final double roiEstimate;
  final double complexityIndex;
  final double completenessRate;
  final double engagementRate;
  final Map<BottleneckSeverity, int> riskDistribution;
  final ProjectHealthGrade healthGrade;

  const ProjectMetricsSnapshot({
    required this.requirementCounts,
    required this.volatilityRate,
    required this.riskScore,
    required this.roiEstimate,
    required this.complexityIndex,
    required this.completenessRate,
    required this.engagementRate,
    required this.riskDistribution,
    required this.healthGrade,
  });

  int get totalRequirements => requirementCounts.values.fold(0, (a, b) => a + b);
}
