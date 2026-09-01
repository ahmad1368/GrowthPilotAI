import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Vendor is typing…" row (Issue #123/#136 AC) — [ChatRoomEntity
/// .isOtherTyping] is a user-toggled local simulation, not a live
/// Socket.io broadcast (see #122).
class ChatTypingIndicator extends StatelessWidget {
  final bool isTyping;
  const ChatTypingIndicator({super.key, required this.isTyping});

  @override
  Widget build(BuildContext context) {
    if (!isTyping) return const SizedBox(height: 20);
    final colors = ShadTheme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text('typing…',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: colors.mutedForeground)),
    );
  }
}
