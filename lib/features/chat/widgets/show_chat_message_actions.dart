import 'package:flutter/material.dart';

/// Long-press action sheet (Issue #132): Reply or Forward a message.
void showChatMessageActions(BuildContext context,
    {required VoidCallback onReply, required VoidCallback onForward}) {
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
      ]),
    ),
  );
}
