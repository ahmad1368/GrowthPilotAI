import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/settings/widgets/delete_account_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Shows the destructive confirmation for account deletion (Issue #189).
/// Returns true only if the user typed DELETE and confirmed.
Future<bool?> showDeleteAccountDialog(BuildContext context) {
  return showShadDialog<bool>(
    context: context,
    builder: (context) => const DeleteAccountDialogContent(),
  );
}
