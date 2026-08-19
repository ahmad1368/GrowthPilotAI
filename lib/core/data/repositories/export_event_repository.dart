import '../../../../objectbox.g.dart';
import '../entities/export_event_entity.dart';

/// Append-only ObjectBox wrapper for [ExportEventEntity] rows (Issue
/// #250) — no update/delete exposed, same WORM pattern as this repo's
/// #186 `SecurityAuditLogRepository`.
class ExportEventRepository {
  final Box<ExportEventEntity> _box;

  ExportEventRepository(this._box);

  void append(ExportEventEntity event) => _box.put(event);

  /// Newest first.
  List<ExportEventEntity> getAll() =>
      _box.getAll()..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
}
