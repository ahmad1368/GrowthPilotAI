import '../../../../objectbox.g.dart';
import '../entities/breach_notification_log_entity.dart';

/// Append-only access to the breach-notification compliance log (Issue
/// #187) — deliberately exposes no update or remove method.
class BreachNotificationLogRepository {
  final Box<BreachNotificationLogEntity> _box;

  BreachNotificationLogRepository(this._box);

  int add(BreachNotificationLogEntity entry) => _box.put(entry);

  List<BreachNotificationLogEntity> getAll() => _box.getAll();
}
