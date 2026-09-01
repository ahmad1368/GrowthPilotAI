import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_message_entity.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/messaging/widgets/translation_chat_actions.dart';
import 'package:growth_pilot_ai/features/messaging/widgets/translation_chat_repos.dart';
import 'package:growth_pilot_ai/features/messaging/widgets/translation_chat_view.dart';

/// Owns the demo cross-language chat state (Issue #430) — a single
/// local conversation demonstrating the on-device translation bridge,
/// not a full multi-user messaging backend (a separate, still-unbuilt
/// feature in this app).
class TranslationChatBody extends StatefulWidget {
  const TranslationChatBody({super.key});
  @override
  State<TranslationChatBody> createState() => _TranslationChatBodyState();
}

class _TranslationChatBodyState extends State<TranslationChatBody> {
  final _repos = TranslationChatRepos();
  late final _actions = TranslationChatActions(_repos);
  late List<ChatMessageEntity> _messages = _repos.messages.getAll();
  AppLocale _composingAs = AppLocale.en;

  void _send(String text) {
    final target = _composingAs == AppLocale.en ? AppLocale.fa : AppLocale.en;
    final sender = _composingAs == AppLocale.en ? 'English Speaker' : 'گوینده فارسی';
    _actions.send(sender, text, _composingAs, target);
    setState(() => _messages = _repos.messages.getAll());
  }

  @override
  Widget build(BuildContext context) {
    return TranslationChatView(
      messages: _messages,
      composingAs: _composingAs,
      onComposingAsChanged: (l) => setState(() => _composingAs = l),
      onSend: _send,
    );
  }
}
