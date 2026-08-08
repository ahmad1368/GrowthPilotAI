import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_message_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flat message bubble (Issue #123/#136) — the issues ask for a
/// Glassmorphism/BackdropFilter "frosted" bubble, which this project's
/// architecture explicitly forbids; uses the theme's primary/card colors
/// instead, matching [CatalogGridCard]'s precedent.
class ChatMessageBubble extends StatelessWidget {
  final ChatRoomMessageEntity message;
  final bool isMe;

  const ChatMessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final time = TimeOfDay.fromDateTime(message.sentAt).format(context);
    return Align(
      alignment: isMe ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? colors.primary : colors.card,
          border: isMe ? null : Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text(message.body,
              style: TextStyle(color: isMe ? colors.primaryForeground : colors.foreground)),
          const SizedBox(height: 2),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text(time,
                style: TextStyle(
                    fontSize: 10,
                    color: (isMe ? colors.primaryForeground : colors.mutedForeground)
                        .withValues(alpha: 0.7))),
            if (isMe) ...[
              const SizedBox(width: 4),
              Icon(message.isRead ? Icons.done_all : Icons.done,
                  size: 12, color: colors.primaryForeground.withValues(alpha: 0.7)),
            ],
          ]),
        ]),
      ),
    );
  }
}
