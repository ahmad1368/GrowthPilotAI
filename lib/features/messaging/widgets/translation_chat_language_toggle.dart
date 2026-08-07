import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

/// Sender-language picker for the composer (Issue #430, acceptance
/// criterion 2) — split out of [TranslationChatComposer].
class TranslationChatLanguageToggle extends StatelessWidget {
  final AppLocale composingAs;
  final void Function(AppLocale) onChanged;

  const TranslationChatLanguageToggle({super.key, required this.composingAs, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ChoiceChip(
        label: const Text('English'),
        selected: composingAs == AppLocale.en,
        onSelected: (_) => onChanged(AppLocale.en),
      ),
      const SizedBox(width: 4),
      ChoiceChip(
        label: const Text('فارسی'),
        selected: composingAs == AppLocale.fa,
        onSelected: (_) => onChanged(AppLocale.fa),
      ),
    ]);
  }
}
