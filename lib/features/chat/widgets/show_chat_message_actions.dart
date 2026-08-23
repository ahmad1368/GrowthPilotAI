import 'package:flutter/material.dart';

/// Long-press action sheet (Issue #132): Reply or Forward a message,
/// plus Edit (feature #18) and Delete (feature #19) — Issue #317 —
/// when [onEdit]/[onDelete] are provided; callers pass them only for
/// the current user's own messages.
void showChatMessageActions(BuildContext context,
    {required VoidCallback onReply,
    required VoidCallback onForward,
    VoidCallback? onEdit,
    VoidCallback? onDelete}) {
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
