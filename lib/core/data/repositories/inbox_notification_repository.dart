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

  /// Prunes cleanup-selected rows (Issue #108 scope item 4) — e.g. stale
  /// read Market Insight entries, so notification history doesn't bloat.
  void removeAll(List<InboxNotificationEntity> entries) =>
      _box.removeMany(entries.map((e) => e.id).toList());
}
