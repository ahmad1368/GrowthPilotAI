import 'package:growth_pilot_ai/core/data/entities/project_metrics_snapshot_entity.dart';
import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/project_health_grade.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';

/// Converts between [ProjectMetricsSnapshot] (pure, in-memory) and
/// [ProjectMetricsSnapshotEntity] (flattened, ObjectBox-persisted) —
/// Issue #237's offline persistence layer.
class ProjectMetricsSnapshotMapper {
  static ProjectMetricsSnapshotEntity toEntity(ProjectMetricsSnapshot snapshot, DateTime capturedAt) {
    return ProjectMetricsSnapshotEntity(
      capturedAt: capturedAt,
      functionalCount: snapshot.requirementCounts[RequirementType.functional] ?? 0,
      nonFunctionalCount: snapshot.requirementCounts[RequirementType.nonFunctional] ?? 0,
      technicalCount: snapshot.requirementCounts[RequirementType.technical] ?? 0,
      businessRuleCount: snapshot.requirementCounts[RequirementType.businessRule] ?? 0,
      volatilityRate: snapshot.volatilityRate,
      riskScore: snapshot.riskScore,
      roiEstimate: snapshot.roiEstimate,
      complexityIndex: snapshot.complexityIndex,
      completenessRate: snapshot.completenessRate,
      engagementRate: snapshot.engagementRate,
      riskLow: snapshot.riskDistribution[BottleneckSeverity.low] ?? 0,
      riskMedium: snapshot.riskDistribution[BottleneckSeverity.medium] ?? 0,
      riskHigh: snapshot.riskDistribution[BottleneckSeverity.high] ?? 0,
      healthScore: snapshot.healthGrade.score,
      healthLetter: snapshot.healthGrade.letter,
    );
  }

  static ProjectMetricsSnapshot fromEntity(ProjectMetricsSnapshotEntity entity) {
    return ProjectMetricsSnapshot(
      requirementCounts: {
        RequirementType.functional: entity.functionalCount,
        RequirementType.nonFunctional: entity.nonFunctionalCount,
        RequirementType.technical: entity.technicalCount,
        RequirementType.businessRule: entity.businessRuleCount,
      },
      volatilityRate: entity.volatilityRate,
      riskScore: entity.riskScore,
      roiEstimate: entity.roiEstimate,
      complexityIndex: entity.complexityIndex,
      completenessRate: entity.completenessRate,
      engagementRate: entity.engagementRate,
      riskDistribution: {
        BottleneckSeverity.low: entity.riskLow,
        BottleneckSeverity.medium: entity.riskMedium,
        BottleneckSeverity.high: entity.riskHigh,
      },
      healthGrade: ProjectHealthGrade(score: entity.healthScore, letter: entity.healthLetter),
    );
  }
}
