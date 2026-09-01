import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The Confirm/Edit/Reject/Link-to-Goal action row (Issue #228/#242).
class RequirementTriageActions extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onEdit;
  final VoidCallback onReject;
  final VoidCallback? onLinkToGoal;

  const RequirementTriageActions({
    super.key,
    required this.onConfirm,
    required this.onEdit,
    required this.onReject,
    this.onLinkToGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        ShadButton(onPressed: onConfirm, child: const Text('Confirm')),
        ShadButton.outline(onPressed: onEdit, child: const Text('Edit')),
        ShadButton.outline(onPressed: onReject, child: const Text('Reject')),
        if (onLinkToGoal != null)
          ShadButton.ghost(onPressed: onLinkToGoal, child: const Text('Link to Goal')),
      ],
    );
  }
}
