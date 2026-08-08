import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';
import 'package:growth_pilot_ai/features/auth/widgets/auth_session_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the session list plus login/revoke-all controls (Issue
/// #120). Purely presentational.
class AuthSessionView extends StatelessWidget {
  final List<AuthSessionEntity> sessions;
  final void Function(String) onLogin;
  final void Function(AuthSessionEntity) onRefresh;
  final VoidCallback onRevokeAll;

  const AuthSessionView({
    super.key,
    required this.sessions,
    required this.onLogin,
    required this.onRefresh,
    required this.onRevokeAll,
  });

  @override
  Widget build(BuildContext context) {
    final active = sessions.where((s) => !s.isRevoked);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ShadButton.ghost(
            onPressed: () => onLogin('This Device'), child: const Text('Simulate Login')),
        ShadButton.ghost(
            onPressed: () => onLogin('Second Device'), child: const Text('+ Second Device')),
        if (active.isNotEmpty)
          ShadButton.ghost(onPressed: onRevokeAll, child: const Text('Revoke All Sessions')),
      ]),
      if (sessions.isEmpty)
        const Text('No sessions yet.', style: TextStyle(fontSize: 12))
      else
        for (final session in sessions)
          AuthSessionRow(session: session, onRefresh: () => onRefresh(session)),
    ]);
  }
}
