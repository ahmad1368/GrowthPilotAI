import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Login and "Log Out All Other Devices" (Issue #173 AC) controls, split
/// out of [AuthSessionView] to keep it under the file's SRP line budget.
class AuthSessionControls extends StatelessWidget {
  final void Function(String) onLogin;
  final void Function(AuthSessionEntity) onRevokeOthers;
  final AuthSessionEntity? current;
  final bool hasOtherActiveSessions;

  const AuthSessionControls({
    super.key,
    required this.onLogin,
    required this.onRevokeOthers,
    required this.current,
    required this.hasOtherActiveSessions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ShadButton.ghost(
          onPressed: () => onLogin('This Device'), child: const Text('Simulate Login')),
      ShadButton.ghost(
          onPressed: () => onLogin('Second Device'), child: const Text('+ Second Device')),
      if (current != null && hasOtherActiveSessions)
        ShadButton.ghost(
            onPressed: () => onRevokeOthers(current!),
            child: const Text('Log Out All Other Devices')),
    ]);
  }
}
