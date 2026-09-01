import '../../../../objectbox.g.dart';
import '../entities/contact_sync_preference_entity.dart';

/// Get-or-create access to the single contact-sync preference row
/// (Issue #541, acceptance criterion 5).
class ContactSyncPreferenceRepository {
  final Box<ContactSyncPreferenceEntity> _box;

  ContactSyncPreferenceRepository(this._box);

  ContactSyncPreferenceEntity get() {
    final existing = _box.getAll().firstOrNull;
    if (existing != null) return existing;
    final created = ContactSyncPreferenceEntity(updatedAt: DateTime.now());
    created.id = _box.put(created);
    return created;
  }

  void setEnabled(bool enabled) {
    final pref = get();
    pref.isEnabled = enabled;
    pref.updatedAt = DateTime.now();
    _box.put(pref);
  }
}
