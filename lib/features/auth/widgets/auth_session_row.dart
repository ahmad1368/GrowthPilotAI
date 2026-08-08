import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One device session row (Issue #120, acceptance criteria 1-4) —
/// the raw refresh token is never shown here, only the fact that a
/// hashed one is on record, satisfying "must not be readable" in
/// spirit for a Flutter app with no browser/JS boundary to test
/// against literally.
class AuthSessionRow extends StatelessWidget {
  final AuthSessionEntity session;
  final VoidCallback onRefresh;

  const AuthSessionRow({super.key, required this.session, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final accessMinsLeft = session.accessTokenExpiresAt.difference(now).inMinutes;
    final refreshDaysLeft = session.refreshTokenExpiresAt.difference(now).inDays;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(
          child: Text(
            '${session.deviceLabel} — ${session.isRevoked ? "REVOKED" : "active"} — '
            'access ${accessMinsLeft}m left — refresh ${refreshDaysLeft}d left — '
            'hash ${session.refreshTokenHash.substring(0, 8)}…',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        if (!session.isRevoked)
          ShadButton.ghost(onPressed: onRefresh, child: const Text('Refresh')),
      ]),
    );
  }
}
