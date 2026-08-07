import '../../../../objectbox.g.dart';
import '../entities/contact_sync_match_entity.dart';

/// CRUD for matched contact-sync results (Issue #541) — [clearAll]
/// backs the "delete my hashed data" privacy control (acceptance
/// criterion 5).
class ContactSyncMatchRepository {
  final Box<ContactSyncMatchEntity> _box;

  ContactSyncMatchRepository(this._box);

  int save(ContactSyncMatchEntity match) => _box.put(match);

  List<ContactSyncMatchEntity> getAll() => _box.getAll();

  void clearAll() => _box.removeAll();
}
