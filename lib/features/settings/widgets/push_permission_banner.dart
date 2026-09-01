import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/services/push_permission_service.dart';

/// Shown only when push is blocked at the OS level (Issue #158 AC) —
/// deep-links into System Settings instead of leaving the in-app Push
/// toggles silently ineffective.
class PushPermissionBanner extends StatelessWidget {
  const PushPermissionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: PushPermissionService.isBlocked(),
      builder: (context, snapshot) {
        if (snapshot.data != true) return const SizedBox.shrink();
        final theme = Theme.of(context);
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.error.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(children: [
            Expanded(
              child: Text('Push notifications are blocked in system settings',
                  style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 12)),
            ),
            const TextButton(
              onPressed: PushPermissionService.openSystemSettings,
              child: Text('Enable'),
            ),
          ]),
        );
      },
    );
  }
}
