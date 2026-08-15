import '../../../../objectbox.g.dart';
import '../entities/notification_conversion_event_entity.dart';

/// Thin ObjectBox wrapper for [NotificationConversionEventEntity] rows
/// (Issue #161).
class NotificationConversionRepository {
  final Box<NotificationConversionEventEntity> _box;

  NotificationConversionRepository(this._box);

  List<NotificationConversionEventEntity> getAll() => _box.getAll();

  void add(NotificationConversionEventEntity event) => _box.put(event);
}
