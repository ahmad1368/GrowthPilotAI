import '../../../../objectbox.g.dart';
import '../entities/inbox_notification_entity.dart';

/// Thin ObjectBox wrapper for dispatched notifications (Issue #71).
class InboxNotificationRepository {
  final Box<InboxNotificationEntity> _box;

  InboxNotificationRepository(this._box);

  List<InboxNotificationEntity> getAll() => _box.getAll();

  List<InboxNotificationEntity> since(DateTime cutoff) =>
      _box.getAll().where((n) => n.createdAt.isAfter(cutoff)).toList();

  void upsert(InboxNotificationEntity notification) => _box.put(notification);
}
