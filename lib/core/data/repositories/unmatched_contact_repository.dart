import '../../../../objectbox.g.dart';
import '../entities/unmatched_contact_entity.dart';

/// Insert/lookup CRUD for non-registered contacts identified during
/// sync (Issue #542, acceptance criterion 1).
class UnmatchedContactRepository {
  final Box<UnmatchedContactEntity> _box;

  UnmatchedContactRepository(this._box);

  int save(UnmatchedContactEntity contact) => _box.put(contact);

  List<UnmatchedContactEntity> getAll() => _box.getAll();

  bool exists(String rawIdentifier) => getAll().any((c) => c.rawIdentifier == rawIdentifier);
}
