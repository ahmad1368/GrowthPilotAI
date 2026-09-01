import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Asks if they want to re-process or use the existing results" (Issue
/// #232's Idempotency Rule) — returns `true` to reuse the cached
/// result, `false` to reprocess, or null if dismissed.
class DocumentReprocessDialog extends StatelessWidget {
  const DocumentReprocessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Document already processed'),
      content: const Text('This exact document was analyzed before. Reuse the existing '
          'results, or reprocess it from scratch?'),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Reprocess'),
        ),
        ShadButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Reuse results'),
        ),
      ],
    );
  }
}
