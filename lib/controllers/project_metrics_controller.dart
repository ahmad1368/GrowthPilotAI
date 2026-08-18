import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_project_metrics.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

/// Drives the KPI "Aggregation Engine" (Issue #233/#236) — recomputes a
/// [ProjectMetricsSnapshot] whenever [recompute] is called with fresh
/// source data. The dashboard UI that visualizes this is Issue #234's
/// own scope; this controller only exposes the computed [snapshot].
class ProjectMetricsController extends GetxController {
  final snapshot = Rxn<ProjectMetricsSnapshot>();

  /// The requirements behind the current [snapshot] — kept for Issue
  /// #236's "long-press the Volatility chart to see what changed".
  List<ExtractedRequirement> sourceRequirements = const [];

  void recompute(
    List<ExtractedRequirement> requirements, {
    List<BottleneckInsight> bottlenecks = const [],
    List<RequirementNode> visualModelNodes = const [],
  }) {
    sourceRequirements = requirements;
    snapshot.value = ComputeProjectMetrics.call(requirements,
        bottlenecks: bottlenecks, visualModelNodes: visualModelNodes);
  }
}
