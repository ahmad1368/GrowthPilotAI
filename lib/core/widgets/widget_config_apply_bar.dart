import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Apply/Reset row for the config side-panel (Issue #116): commits the
/// [WidgetPreviewController]'s dirty preview to Secure Storage, or discards
/// it back to the last saved state. Hidden entirely when nothing is dirty.
class WidgetConfigApplyBar extends StatelessWidget {
  final bool isPreviewing;
  final VoidCallback onApply;
  final VoidCallback onReset;

  const WidgetConfigApplyBar({
    super.key,
    required this.isPreviewing,
    required this.onApply,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPreviewing) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(
            child: ShadButton.outline(
                onPressed: onReset, child: const Text('Reset')),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ShadButton(onPressed: onApply, child: const Text('Apply')),
          ),
        ],
      ),
    );
  }
}
