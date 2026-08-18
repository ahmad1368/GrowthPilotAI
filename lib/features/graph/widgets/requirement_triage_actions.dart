import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The Confirm/Edit/Reject action row (Issue #228).
class RequirementTriageActions extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onEdit;
  final VoidCallback onReject;

  const RequirementTriageActions({
    super.key,
    required this.onConfirm,
    required this.onEdit,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShadButton(onPressed: onConfirm, child: const Text('Confirm')),
        const SizedBox(width: 8),
        ShadButton.outline(onPressed: onEdit, child: const Text('Edit')),
        const SizedBox(width: 8),
        ShadButton.outline(onPressed: onReject, child: const Text('Reject')),
      ],
    );
  }
}
