import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_project_metrics.dart';
import 'package:growth_pilot_ai/core/data/repositories/project_metrics_snapshot_repository.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot_mapper.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';

/// Drives the KPI "Aggregation Engine" (Issue #233/#236/#234/#237) —
/// recomputes a [ProjectMetricsSnapshot] whenever [recompute] is called
/// with fresh source data. Issue #237's "Stale-While-Revalidate":
/// [onInit] loads whatever was last persisted to ObjectBox into
/// [history] immediately (the "stale" cache, survives app restart),
/// and every [recompute] both updates the in-memory state and persists
/// the fresh snapshot (the "revalidate" step).
class ProjectMetricsController extends GetxController {
  final ProjectMetricsSnapshotRepository _repository;

  ProjectMetricsController(this._repository);

  final snapshot = Rxn<ProjectMetricsSnapshot>();
  final history = <ProjectMetricsSnapshot>[].obs;

  /// The requirements behind the current [snapshot] — kept for Issue
  /// #236's "long-press the Volatility chart to see what changed". Not
  /// persisted (see PR notes: only the aggregated snapshot is).
  List<ExtractedRequirement> sourceRequirements = const [];

  @override
  void onInit() {
    super.onInit();
    final persisted = _repository.loadHistory().map(ProjectMetricsSnapshotMapper.fromEntity).toList();
    if (persisted.isEmpty) return;
    history.assignAll(persisted);
    snapshot.value = persisted.last;
  }

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
    _repository.save(ProjectMetricsSnapshotMapper.toEntity(computed, DateTime.now()));
  }
}
