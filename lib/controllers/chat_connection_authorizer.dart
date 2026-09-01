import 'package:growth_pilot_ai/business/authorize_chat_connection.dart';
import 'package:growth_pilot_ai/core/data/repositories/auth_session_repository.dart';

/// Gates chat gateway connections behind a valid session (Issue #131 AC:
/// JWT-authenticated socket connections).
class ChatConnectionAuthorizer {
  final AuthSessionRepository _sessions;

  ChatConnectionAuthorizer(this._sessions);

  bool isAuthorized() =>
      AuthorizeChatConnection.call(_sessions.getActive(), DateTime.now());
}
