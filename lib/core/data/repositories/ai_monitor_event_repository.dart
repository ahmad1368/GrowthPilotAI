import '../../../../objectbox.g.dart';
import '../entities/ai_monitor_event_entity.dart';

/// Thin ObjectBox wrapper for [AiMonitorEventEntity] rows (Issue #210).
class AiMonitorEventRepository {
  final Box<AiMonitorEventEntity> _box;

  AiMonitorEventRepository(this._box);

  List<AiMonitorEventEntity> getAll() => _box.getAll();

  void add(AiMonitorEventEntity event) => _box.put(event);
}
