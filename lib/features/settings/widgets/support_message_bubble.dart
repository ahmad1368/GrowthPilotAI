import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/data/entities/support_message_entity.dart';
import 'package:growth_pilot_ai/core/enum/support_message_sender.dart';

/// Flat message bubble for the local mock support chat (Issue #193)
/// — no glassmorphism/BackdropFilter, matching this repo's existing
/// #123 `ChatMessageBubble` precedent.
class SupportMessageBubble extends StatelessWidget {
  final SupportMessageEntity message;

  const SupportMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final isUser = message.sender == SupportMessageSender.user;
    final fg = isUser ? colors.primaryForeground : colors.foreground;
    final time = TimeOfDay.fromDateTime(message.sentAt).format(context);

    return Align(
      alignment: isUser ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? colors.primary : colors.card,
          border: isUser ? null : Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text(message.body, style: TextStyle(color: fg)),
          const SizedBox(height: 2),
          Text(time, style: TextStyle(fontSize: 10, color: fg.withValues(alpha: 0.7))),
        ]),
      ),
    );
  }
}
