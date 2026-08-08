import '../../../../objectbox.g.dart';
import '../entities/auth_session_entity.dart';

/// CRUD for device sessions (Issue #120) — [revokeAll] backs the
/// "Revoke all sessions" acceptance criterion.
class AuthSessionRepository {
  final Box<AuthSessionEntity> _box;

  AuthSessionRepository(this._box);

  int save(AuthSessionEntity session) => _box.put(session);

  List<AuthSessionEntity> getAll() => _box.getAll();

  List<AuthSessionEntity> getActive() => getAll().where((s) => !s.isRevoked).toList();

  void revokeAll() {
    for (final session in getAll()) {
      session.isRevoked = true;
      _box.put(session);
    }
  }
}
