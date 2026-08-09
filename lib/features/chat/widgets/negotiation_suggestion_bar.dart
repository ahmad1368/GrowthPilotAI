import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Smart Suggestion overlay" (Issue #152 UI) — flat one-tap chips, not
/// the issue's literal `GlassActionChip` ask (architecture forbids
/// Glassmorphism/BackdropFilter). Tapping a chip only fills/sends via
/// [onSelect]; the AI never sends on the user's behalf.
class NegotiationSuggestionBar extends StatelessWidget {
  final List<String> suggestions;
  final bool riskFlagged;
  final void Function(String) onSelect;

  const NegotiationSuggestionBar({
    super.key,
    required this.suggestions,
    required this.riskFlagged,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();
    final colors = ShadTheme.of(context).colorScheme;
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) => ShadButton.outline(
          onPressed: () => onSelect(suggestions[index]),
          leading: Icon(Icons.auto_awesome,
              size: 14, color: riskFlagged ? colors.destructive : colors.primary),
          child: Text(suggestions[index], style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }
}
