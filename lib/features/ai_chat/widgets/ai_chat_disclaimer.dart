import 'package:flutter/material.dart';

/// Non-advisory disclaimer (Issue #201 legal requirement for FinTech in
/// Canada) — always visible, not just in the empty state.
class AiChatDisclaimer extends StatelessWidget {
  const AiChatDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Text(
        'AI insights are for informational purposes and do not replace professional accounting advice.',
        style: TextStyle(fontSize: 10, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
      ),
    );
  }
}
