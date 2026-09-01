import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Confirms a batch archive of more than [RequiresBulkConfirmation.threshold]
/// conversations at once (Issue #76), so a stray "Select All" + "Archive"
/// can't silently wipe out the inbox. Mirrors [showDisconnectConfirmDialog].
Future<bool> showConfirmBulkArchiveDialog(
  BuildContext context, {
  required int itemCount,
}) async {
  final confirmed = await showShadDialog<bool>(
    context: context,
    builder: (context) => ShadDialog.alert(
      title: const Text('Archive conversations?'),
      description: Text(
          'This will archive $itemCount conversations at once. You can undo this from the snackbar right after.'),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ShadButton.destructive(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Archive'),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
