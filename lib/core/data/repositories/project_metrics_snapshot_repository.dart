import '../../../../objectbox.g.dart';
import '../entities/project_metrics_snapshot_entity.dart';

/// Thin ObjectBox wrapper for [ProjectMetricsSnapshotEntity] rows
/// (Issue #237) — persists the KPI dashboard's history so it "remains
/// accessible even when offline".
class ProjectMetricsSnapshotRepository {
  final Box<ProjectMetricsSnapshotEntity> _box;

  ProjectMetricsSnapshotRepository(this._box);

  void save(ProjectMetricsSnapshotEntity entity) => _box.put(entity);

  List<ProjectMetricsSnapshotEntity> loadHistory() =>
      _box.getAll()..sort((a, b) => a.capturedAt.compareTo(b.capturedAt));

  ProjectMetricsSnapshotEntity? loadLatest() {
    final all = loadHistory();
    return all.isEmpty ? null : all.last;
  }
}
