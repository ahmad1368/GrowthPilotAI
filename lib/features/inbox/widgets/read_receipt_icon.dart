import 'package:flutter/material.dart';

/// "Read Receipt" indicator (Issue #78): a single check while the latest
/// message is unread, a double check once it's been read — the local
/// equivalent of the issue's real-time Socket.io status icon.
class ReadReceiptIcon extends StatelessWidget {
  final bool isRead;

  const ReadReceiptIcon({super.key, required this.isRead});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isRead ? Icons.done_all_rounded : Icons.done_rounded,
      size: 14,
      color: isRead ? Theme.of(context).colorScheme.primary : null,
    );
  }
}
