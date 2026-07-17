import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Confirms disconnecting a provider (Issue #61) before it happens — warns
/// that real-time updates stop and, for accounting providers, that
/// auto-map rules are cleared. Returns true only if the user confirms.
Future<bool> showDisconnectConfirmDialog(
  BuildContext context, {
  required String providerLabel,
  required bool willClearMappingRules,
}) async {
  final confirmed = await showShadDialog<bool>(
    context: context,
    builder: (context) => ShadDialog.alert(
      title: Text('Disconnect $providerLabel?'),
      description: Text(willClearMappingRules
          ? 'Real-time updates will stop and your Category Mapping '
              'auto-map rules will be cleared.'
          : 'Real-time updates from $providerLabel will stop.'),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ShadButton.destructive(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Disconnect'),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
