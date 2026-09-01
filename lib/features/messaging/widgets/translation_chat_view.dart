import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_message_entity.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/messaging/widgets/translation_chat_bubble.dart';
import 'package:growth_pilot_ai/features/messaging/widgets/translation_chat_composer.dart';

/// Renders the demo conversation and composer (Issue #430). Purely
/// presentational.
class TranslationChatView extends StatelessWidget {
  final List<ChatMessageEntity> messages;
  final AppLocale composingAs;
  final void Function(AppLocale) onComposingAsChanged;
  final void Function(String) onSend;

  const TranslationChatView({
    super.key,
    required this.messages,
    required this.composingAs,
    required this.onComposingAsChanged,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (messages.isEmpty)
        const Text('No messages yet — compose one below to see the on-device translation bridge.',
            style: TextStyle(fontSize: 12))
      else
        for (final message in messages) TranslationChatBubble(message: message),
      const SizedBox(height: 8),
      TranslationChatComposer(
        composingAs: composingAs,
        onComposingAsChanged: onComposingAsChanged,
        onSend: onSend,
      ),
    ]);
  }
}
