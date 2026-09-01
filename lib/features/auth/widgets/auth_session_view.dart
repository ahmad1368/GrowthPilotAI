import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';
import 'package:growth_pilot_ai/features/auth/widgets/auth_session_controls.dart';
import 'package:growth_pilot_ai/features/auth/widgets/auth_session_row.dart';

/// Renders the session list plus login/revoke-all controls (Issue
/// #120). Purely presentational.
class AuthSessionView extends StatelessWidget {
  final List<AuthSessionEntity> sessions;
  final void Function(String) onLogin;
  final void Function(AuthSessionEntity) onRefresh;
  final void Function(AuthSessionEntity) onRevoke;
  final void Function(AuthSessionEntity) onRevokeOthers;

  const AuthSessionView({
    super.key,
    required this.sessions,
    required this.onLogin,
    required this.onRefresh,
    required this.onRevoke,
    required this.onRevokeOthers,
  });

  @override
  Widget build(BuildContext context) {
    final active = sessions.where((s) => !s.isRevoked).toList();
    // "This device" (Issue #173 AC: never log out the acting device) is the
    // first active session — the demo's login flow always creates it first.
    final current = active.isEmpty ? null : active.first;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AuthSessionControls(
        onLogin: onLogin,
        onRevokeOthers: onRevokeOthers,
        current: current,
        hasOtherActiveSessions: active.length > 1,
      ),
      if (sessions.isEmpty)
        const Text('No sessions yet.', style: TextStyle(fontSize: 12))
      else
        for (final session in sessions)
          AuthSessionRow(
            session: session,
            isCurrent: session == current,
            onRefresh: () => onRefresh(session),
            onRevoke: () => onRevoke(session),
          ),
    ]);
  }
}
