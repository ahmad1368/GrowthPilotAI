import 'package:flutter/material.dart';

/// Long-press action sheet (Issue #132): Reply or Forward a message,
/// plus Edit (feature #18), Pin/Unpin (feature #22), and Delete
/// (feature #19) — Issue #317. [onEdit]/[onDelete] are passed only for
/// the current user's own messages; [onTogglePin] is available to any
/// participant, since pinning is room curation, not an ownership action.
void showChatMessageActions(BuildContext context,
    {required VoidCallback onReply,
    required VoidCallback onForward,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
    required VoidCallback onTogglePin,
    required bool isPinned}) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          leading: const Icon(Icons.reply),
          title: const Text('Reply'),
          onTap: () {
            Navigator.pop(context);
            onReply();
          },
        ),
        ListTile(
          leading: const Icon(Icons.forward),
          title: const Text('Forward'),
          onTap: () {
            Navigator.pop(context);
            onForward();
          },
        ),
        if (onEdit != null)
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
          ),
        ListTile(
          leading: Icon(isPinned ? Icons.push_pin : Icons.push_pin_outlined),
          title: Text(isPinned ? 'Unpin' : 'Pin'),
          onTap: () {
            Navigator.pop(context);
            onTogglePin();
          },
        ),
        if (onDelete != null)
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete for Everyone'),
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
          ),
      ]),
    ),
  );
}
