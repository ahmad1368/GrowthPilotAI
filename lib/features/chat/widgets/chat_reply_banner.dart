import 'package:flutter/material.dart';

/// Cancellable "Replying to…" banner shown above the input bar
/// (Issue #132).
class ChatReplyBanner extends StatelessWidget {
  final String preview;
  final VoidCallback? onCancel;

  const ChatReplyBanner({super.key, required this.preview, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Text('Replying to: $preview',
              maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11))),
      IconButton(
          icon: const Icon(Icons.close, size: 14),
          onPressed: onCancel,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints()),
    ]);
  }
}
