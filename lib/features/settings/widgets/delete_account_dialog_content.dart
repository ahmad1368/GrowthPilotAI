import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/is_delete_confirmation_valid.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Confirmation body for [showDeleteAccountDialog] (Issue #189) — the
/// "Delete" button stays disabled until the user types DELETE, so a
/// stray tap can't wipe local data.
class DeleteAccountDialogContent extends StatefulWidget {
  const DeleteAccountDialogContent({super.key});

  @override
  State<DeleteAccountDialogContent> createState() => _DeleteAccountDialogContentState();
}

class _DeleteAccountDialogContentState extends State<DeleteAccountDialogContent> {
  final _controller = TextEditingController();
  bool _canDelete = false;

  void _onChanged(String value) => setState(() => _canDelete = IsDeleteConfirmationValid.call(value));

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Delete Account'),
      description: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('This permanently erases all local data on this device — transactions, invoices, chat, '
            'and settings. This cannot be undone.'),
        const SizedBox(height: 12),
        Text('Type DELETE to confirm.', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 8),
        ShadInput(controller: _controller, placeholder: const Text('DELETE'), onChanged: _onChanged),
      ]),
      actions: [
        ShadButton.outline(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
        ShadButton.destructive(
          enabled: _canDelete,
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete Everything'),
        ),
      ],
    );
  }
}
