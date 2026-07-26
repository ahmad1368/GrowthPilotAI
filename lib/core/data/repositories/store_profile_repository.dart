import '../../../../objectbox.g.dart';
import '../entities/store_profile_entity.dart';

/// Single-row CRUD for the store profile (Issue #398): reads the one
/// existing row if present, otherwise a zero-valued default.
class StoreProfileRepository {
  final Box<StoreProfileEntity> _box;

  StoreProfileRepository(this._box);

  StoreProfileEntity get() {
    final rows = _box.getAll();
    return rows.isEmpty ? StoreProfileEntity() : rows.first;
  }

  int save(StoreProfileEntity profile) => _box.put(profile);
}
