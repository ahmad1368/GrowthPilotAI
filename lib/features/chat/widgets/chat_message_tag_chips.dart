import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Smart Chips" (Issue #128 UI Visualization AC) — flat pills, not the
/// issue's literal Glassmorphism ask (architecture forbids
/// Glassmorphism/BackdropFilter).
class ChatMessageTagChips extends StatelessWidget {
  final List<String> tags;

  const ChatMessageTagChips({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();
    final colors = ShadTheme.of(context).colorScheme;
    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: tags
          .map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration:
                    BoxDecoration(color: colors.muted, borderRadius: BorderRadius.circular(10)),
                child: Text(tag, style: TextStyle(fontSize: 9, color: colors.mutedForeground)),
              ))
          .toList(),
    );
  }
}
