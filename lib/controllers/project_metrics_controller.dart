import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_project_metrics.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

/// Drives the KPI "Aggregation Engine" (Issue #233/#236/#234) —
/// recomputes a [ProjectMetricsSnapshot] whenever [recompute] is called
/// with fresh source data, keeping [history] for Issue #234's
/// "Volatility over time" trend chart (session-only — no persisted
/// history across app restarts; see PR notes).
class ProjectMetricsController extends GetxController {
  final snapshot = Rxn<ProjectMetricsSnapshot>();
  final history = <ProjectMetricsSnapshot>[].obs;

  /// The requirements behind the current [snapshot] — kept for Issue
  /// #236's "long-press the Volatility chart to see what changed".
  List<ExtractedRequirement> sourceRequirements = const [];

  void recompute(
    List<ExtractedRequirement> requirements, {
    List<BottleneckInsight> bottlenecks = const [],
    List<RequirementNode> visualModelNodes = const [],
  }) {
    sourceRequirements = requirements;
    final computed = ComputeProjectMetrics.call(requirements,
        bottlenecks: bottlenecks, visualModelNodes: visualModelNodes);
    snapshot.value = computed;
    history.add(computed);
  }
}
