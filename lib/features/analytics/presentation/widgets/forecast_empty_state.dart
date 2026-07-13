import 'package:flutter/material.dart';

/// Shown when there isn't enough history to forecast (< 3 active days).
class ForecastEmptyState extends StatelessWidget {
  const ForecastEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = theme.colorScheme.onSurface;
    return Row(
      children: [
        Icon(Icons.document_scanner_outlined,
            color: fg.withValues(alpha: 0.7)),
        const SizedBox(width: 12),
        Expanded(
          child: Text('Scan more receipts to unlock predictions.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: fg.withValues(alpha: 0.8))),
        ),
      ],
    );
  }
}
