import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/messaging/widgets/translation_chat_language_toggle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Text input plus sender-language toggle for composing a message
/// (Issue #430, acceptance criterion 2).
class TranslationChatComposer extends StatefulWidget {
  final AppLocale composingAs;
  final void Function(AppLocale) onComposingAsChanged;
  final void Function(String) onSend;

  const TranslationChatComposer({
    super.key,
    required this.composingAs,
    required this.onComposingAsChanged,
    required this.onSend,
  });

  @override
  State<TranslationChatComposer> createState() => _TranslationChatComposerState();
}

class _TranslationChatComposerState extends State<TranslationChatComposer> {
  final _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TranslationChatLanguageToggle(
          composingAs: widget.composingAs, onChanged: widget.onComposingAsChanged),
      Row(children: [
        Expanded(child: TextField(controller: _controller, style: const TextStyle(fontSize: 13))),
        ShadButton.ghost(onPressed: _submit, child: const Text('Send')),
      ]),
    ]);
  }
}
