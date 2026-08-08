import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';
import 'package:growth_pilot_ai/features/auth/widgets/auth_session_actions.dart';
import 'package:growth_pilot_ai/features/auth/widgets/auth_session_repos.dart';
import 'package:growth_pilot_ai/features/auth/widgets/auth_session_view.dart';

/// Owns the demo session-lifecycle state (Issue #120) — this app has
/// no login/registration screen anywhere, so "login" here just opens
/// a new named device session to demonstrate the token model.
class AuthSessionBody extends StatefulWidget {
  const AuthSessionBody({super.key});
  @override
  State<AuthSessionBody> createState() => _AuthSessionBodyState();
}

class _AuthSessionBodyState extends State<AuthSessionBody> {
  final _repos = AuthSessionRepos();
  late final _actions = AuthSessionActions(_repos);
  late List<AuthSessionEntity> _sessions = _repos.sessions.getAll();

  void _login(String deviceLabel) {
    _actions.login(deviceLabel);
    setState(() => _sessions = _repos.sessions.getAll());
  }

  void _refresh(AuthSessionEntity session) {
    _actions.refresh(session);
    setState(() => _sessions = _repos.sessions.getAll());
  }

  void _revokeAll() {
    _actions.revokeAll();
    setState(() => _sessions = _repos.sessions.getAll());
  }

  @override
  Widget build(BuildContext context) {
    return AuthSessionView(
      sessions: _sessions,
      onLogin: _login,
      onRefresh: _refresh,
      onRevokeAll: _revokeAll,
    );
  }
}
