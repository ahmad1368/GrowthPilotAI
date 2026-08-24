import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Shown in place of a screen's content when [HasPermission] returns
/// false (Issue #174's "Action Blocking" AC — even direct navigation to
/// a restricted screen must be blocked, not just hidden from the menu).
/// Flat shadcn_ui per docs/adr/0003, not the issue's literal
/// Glassmorphism ask. Needs a ShadTheme ancestor from its host screen.
class AccessDeniedView extends StatelessWidget {
  final String requiredPermissionLabel;

  const AccessDeniedView({super.key, required this.requiredPermissionLabel});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Center(
      child: ShadCard(
        width: 320,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.lock_outline_rounded, color: colors.mutedForeground, size: 32),
          const SizedBox(height: 12),
          Text('Access Denied', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            'You need the "$requiredPermissionLabel" permission to view this. Ask your business owner to grant it.',
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.mutedForeground, fontSize: 12),
          ),
        ]),
      ),
    );
  }
}
