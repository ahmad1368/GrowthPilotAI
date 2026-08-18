import 'package:growth_pilot_ai/business/compute_bottleneck_risk_score.dart';
import 'package:growth_pilot_ai/business/compute_bottleneck_severity_distribution.dart';
import 'package:growth_pilot_ai/business/compute_project_health_grade.dart';
import 'package:growth_pilot_ai/business/compute_requirement_completeness.dart';
import 'package:growth_pilot_ai/business/compute_requirement_engagement.dart';
import 'package:growth_pilot_ai/business/compute_requirement_roi_estimate.dart';
import 'package:growth_pilot_ai/business/compute_requirement_type_counts.dart';
import 'package:growth_pilot_ai/business/compute_requirement_volatility.dart';
import 'package:growth_pilot_ai/business/compute_visual_model_complexity_index.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

/// Combines the individual `Compute*` KPIs into one
/// [ProjectMetricsSnapshot] (Issue #233/#236's "Aggregation Engine").
class ComputeProjectMetrics {
  static ProjectMetricsSnapshot call(
    List<ExtractedRequirement> requirements, {
    List<BottleneckInsight> bottlenecks = const [],
    List<RequirementNode> visualModelNodes = const [],
  }) {
    final volatility = ComputeRequirementVolatility.call(requirements);
    final engagement = ComputeRequirementEngagement.call(requirements);
    final completeness = ComputeRequirementCompleteness.call(requirements);
    final risk = ComputeBottleneckRiskScore.call(bottlenecks);

    return ProjectMetricsSnapshot(
      requirementCounts: ComputeRequirementTypeCounts.call(requirements),
      volatilityRate: volatility,
      riskScore: risk,
      roiEstimate: ComputeRequirementRoiEstimate.call(requirements),
      complexityIndex: ComputeVisualModelComplexityIndex.call(visualModelNodes),
      completenessRate: completeness,
      engagementRate: engagement,
      riskDistribution: ComputeBottleneckSeverityDistribution.call(bottlenecks),
      healthGrade: ComputeProjectHealthGrade.call(
        volatilityRate: volatility,
        engagementRate: engagement,
        completenessRate: completeness,
        riskScore: risk,
      ),
    );
  }
}
