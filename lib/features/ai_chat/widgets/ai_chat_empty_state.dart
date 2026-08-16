import 'package:flutter/material.dart';

/// Welcome message shown instead of an empty message list (Issue #201
/// AC: "The Empty State of the chat now shows a welcoming message + 4
/// suggestion chips" — the chips themselves are rendered by the caller
/// below this).
class AiChatEmptyState extends StatelessWidget {
  const AiChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Hi! Ask me about your business finances, or tap a suggestion below to get started.',
          textAlign: TextAlign.center,
          style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.7)),
        ),
      ),
    );
  }
}
