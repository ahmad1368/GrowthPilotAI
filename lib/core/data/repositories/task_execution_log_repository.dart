import '../../../../objectbox.g.dart';
import '../entities/task_execution_log_entity.dart';

/// Append-only access to the task execution log (Issue #406, acceptance
/// criterion 4) — intentionally exposes no update/delete, mirroring
/// [AuditLogRepository]'s immutable-log pattern.
class TaskExecutionLogRepository {
  final Box<TaskExecutionLogEntity> _box;

  TaskExecutionLogRepository(this._box);

  int record(TaskExecutionLogEntity log) => _box.put(log);

  List<TaskExecutionLogEntity> getAll() => _box.getAll();
}
