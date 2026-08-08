import 'package:growth_pilot_ai/business/create_auth_session.dart';
import 'package:growth_pilot_ai/business/rotate_auth_session.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';
import 'package:growth_pilot_ai/features/auth/widgets/auth_session_repos.dart';

/// Login, refresh-token rotation, and revocation for the demo session
/// lifecycle (Issue #120, acceptance criteria 1-4) — split out of
/// [AuthSessionBody].
class AuthSessionActions {
  final AuthSessionRepos repos;

  AuthSessionActions(this.repos);

  AuthSessionEntity login(String deviceLabel) {
    final result = CreateAuthSession.call(deviceLabel, DateTime.now());
    result.session.id = repos.sessions.save(result.session);
    return result.session;
  }

  AuthSessionEntity? refresh(AuthSessionEntity session) {
    final result = RotateAuthSession.call(session, DateTime.now());
    if (result == null) return null;
    session.isRevoked = true;
    repos.sessions.save(session);
    result.session.id = repos.sessions.save(result.session);
    return result.session;
  }

  void revokeAll() => repos.sessions.revokeAll();
}
