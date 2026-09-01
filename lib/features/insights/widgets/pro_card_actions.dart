import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Act/Save/Dismiss row for [ProCard], split out to keep the card under
/// the file's SRP line budget.
class ProCardActions extends StatelessWidget {
  final String actionLabel;
  final bool isProcessing;
  final VoidCallback onAct;
  final VoidCallback onSave;
  final VoidCallback onDismiss;

  const ProCardActions({
    super.key,
    required this.actionLabel,
    required this.isProcessing,
    required this.onAct,
    required this.onSave,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 4, children: [
      ShadButton(
          enabled: !isProcessing, size: ShadButtonSize.sm, onPressed: onAct, child: Text(actionLabel)),
      ShadButton.outline(
          enabled: !isProcessing, size: ShadButtonSize.sm, onPressed: onSave, child: const Text('Save')),
      ShadButton.ghost(
          enabled: !isProcessing,
          size: ShadButtonSize.sm,
          onPressed: onDismiss,
          child: const Text('Dismiss')),
    ]);
  }
}
