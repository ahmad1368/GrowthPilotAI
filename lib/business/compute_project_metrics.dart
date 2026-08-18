import 'package:growth_pilot_ai/business/compute_bottleneck_risk_score.dart';
import 'package:growth_pilot_ai/business/compute_requirement_roi_estimate.dart';
import 'package:growth_pilot_ai/business/compute_requirement_type_counts.dart';
import 'package:growth_pilot_ai/business/compute_requirement_volatility.dart';
import 'package:growth_pilot_ai/business/compute_visual_model_complexity_index.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

/// Combines the individual `Compute*` KPIs into one
/// [ProjectMetricsSnapshot] (Issue #233's "Aggregation Engine").
class ComputeProjectMetrics {
  static ProjectMetricsSnapshot call(
    List<ExtractedRequirement> requirements, {
    List<BottleneckInsight> bottlenecks = const [],
    List<RequirementNode> visualModelNodes = const [],
  }) {
    return ProjectMetricsSnapshot(
      requirementCounts: ComputeRequirementTypeCounts.call(requirements),
      volatilityRate: ComputeRequirementVolatility.call(requirements),
      riskScore: ComputeBottleneckRiskScore.call(bottlenecks),
      roiEstimate: ComputeRequirementRoiEstimate.call(requirements),
      complexityIndex: ComputeVisualModelComplexityIndex.call(visualModelNodes),
    );
  }
}
