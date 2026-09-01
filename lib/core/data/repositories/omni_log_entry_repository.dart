import '../../../../objectbox.g.dart';
import '../entities/omni_log_entry_entity.dart';

/// Thin ObjectBox wrapper for offline-persisted log entries (Issue #266).
class OmniLogEntryRepository {
  final Box<OmniLogEntryEntity> _box;

  OmniLogEntryRepository(this._box);

  int insert(OmniLogEntryEntity entry) => _box.put(entry);

  List<OmniLogEntryEntity> getRecent({int limit = 200}) {
    final query = _box
        .query()
        .order(OmniLogEntryEntity_.occurredAt, flags: Order.descending)
        .build()
      ..limit = limit;
    final result = query.find();
    query.close();
    return result;
  }
}
