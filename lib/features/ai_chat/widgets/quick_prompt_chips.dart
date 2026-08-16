import 'package:flutter/material.dart';

/// Contextual prompt suggestions above the chat input (Issue #200 AC:
/// "Quick Prompts").
class QuickPromptChips extends StatelessWidget {
  final List<String> prompts;
  final ValueChanged<String> onTap;
  const QuickPromptChips({super.key, required this.prompts, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: prompts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) => ActionChip(
          label: Text(prompts[i], style: const TextStyle(fontSize: 12)),
          onPressed: () => onTap(prompts[i]),
        ),
      ),
    );
  }
}
