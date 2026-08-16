import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/chat_message.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/chat_message_text.dart';

/// One chat bubble (Issue #200) — flat surface, not the issue's literal
/// Glassmorphism ask (this app's architecture forbids BackdropFilter).
class AiChatBubble extends StatelessWidget {
  final ChatMessage message;
  const AiChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isFromUser;
    final bg = isUser ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.08);
    final fg = isUser ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: ChatMessageText(text: message.text, color: fg),
      ),
    );
  }
}
