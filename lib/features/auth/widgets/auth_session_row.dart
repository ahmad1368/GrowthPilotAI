import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One device session row (Issue #120; per-row revoke and last-active
/// display added for #173). The raw refresh token is never shown, only
/// that a hashed one is on record.
class AuthSessionRow extends StatelessWidget {
  final AuthSessionEntity session;
  final bool isCurrent;
  final VoidCallback onRefresh;
  final VoidCallback onRevoke;

  const AuthSessionRow({
    super.key,
    required this.session,
    required this.isCurrent,
    required this.onRefresh,
    required this.onRevoke,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final accessMinsLeft = session.accessTokenExpiresAt.difference(now).inMinutes;
    final refreshDaysLeft = session.refreshTokenExpiresAt.difference(now).inDays;
    final lastActiveMinsAgo = now.difference(session.lastActiveAt).inMinutes;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(
          child: Text(
            '${session.deviceLabel}${isCurrent ? " (this device)" : ""} — '
            '${session.isRevoked ? "REVOKED" : "active"} — '
            'last active ${lastActiveMinsAgo}m ago — '
            'access ${accessMinsLeft}m left — refresh ${refreshDaysLeft}d left — '
            'hash ${session.refreshTokenHash.substring(0, 8)}…',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        if (!session.isRevoked) ...[
          ShadButton.ghost(onPressed: onRefresh, child: const Text('Refresh')),
          if (!isCurrent)
            ShadButton.ghost(onPressed: onRevoke, child: const Text('Revoke')),
        ],
      ]),
    );
  }
}
