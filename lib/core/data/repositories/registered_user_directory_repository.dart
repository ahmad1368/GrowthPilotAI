import '../../../../objectbox.g.dart';
import '../entities/registered_user_directory_entity.dart';

/// Insert/lookup CRUD for the simulated registered-user directory
/// (Issue #541).
class RegisteredUserDirectoryRepository {
  final Box<RegisteredUserDirectoryEntity> _box;

  RegisteredUserDirectoryRepository(this._box);

  int save(RegisteredUserDirectoryEntity user) => _box.put(user);

  List<RegisteredUserDirectoryEntity> getAll() => _box.getAll();
}
