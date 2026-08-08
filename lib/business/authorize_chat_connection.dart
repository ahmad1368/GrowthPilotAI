import 'package:growth_pilot_ai/business/is_session_token_expired.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';

/// Gates a chat gateway connection behind a valid session (Issue #131 AC:
/// "Every socket connection must be authenticated using the JWT Access
/// Token from Issue #120").
class AuthorizeChatConnection {
  static bool call(List<AuthSessionEntity> activeSessions, DateTime now) {
    return activeSessions.any((session) =>
        !session.isRevoked &&
        !IsSessionTokenExpired.call(session.accessTokenExpiresAt, now));
  }
}
