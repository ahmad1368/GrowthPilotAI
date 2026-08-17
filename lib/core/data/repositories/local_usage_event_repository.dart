import '../../../../objectbox.g.dart';
import '../entities/local_usage_event_entity.dart';

/// Append-only access to the local usage-event log (Issue #539) —
/// deliberately exposes no update or remove method.
class LocalUsageEventRepository {
  final Box<LocalUsageEventEntity> _box;

  LocalUsageEventRepository(this._box);

  int add(LocalUsageEventEntity event) => _box.put(event);

  List<LocalUsageEventEntity> getAll() => _box.getAll();
}
