import '../../../../objectbox.g.dart';
import '../entities/scheduled_task_entity.dart';

/// Insert-or-update CRUD for scheduled tasks (Issue #406), mirroring
/// [MerchantConfigRepository]'s upsert pattern.
class ScheduledTaskRepository {
  final Box<ScheduledTaskEntity> _box;

  ScheduledTaskRepository(this._box);

  int save(ScheduledTaskEntity task) => _box.put(task);

  List<ScheduledTaskEntity> getAll() => _box.getAll();
}
