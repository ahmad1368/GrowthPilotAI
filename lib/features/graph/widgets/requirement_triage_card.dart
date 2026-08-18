import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One candidate requirement card (Issue #228) — Confirm/Edit/Reject,
/// with the indicator phrase that triggered extraction. Flat, no
/// Glassmorphism.
class RequirementTriageCard extends StatelessWidget {
  final ExtractedRequirement requirement;
  final VoidCallback onConfirm;
  final VoidCallback onReject;
  final VoidCallback onEdit;

  const RequirementTriageCard({
    super.key,
    required this.requirement,
    required this.onConfirm,
    required this.onReject,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(requirement.description, style: TextStyle(color: colors.foreground, fontSize: 13)),
          const SizedBox(height: 4),
          Text('${requirement.type.name} · ${requirement.priorityHint.name} · "${requirement.indicator}"',
              style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
          const SizedBox(height: 8),
          Row(
            children: [
              ShadButton(onPressed: onConfirm, child: const Text('Confirm')),
              const SizedBox(width: 8),
              ShadButton.outline(onPressed: onEdit, child: const Text('Edit')),
              const SizedBox(width: 8),
              ShadButton.outline(onPressed: onReject, child: const Text('Reject')),
            ],
          ),
        ],
      ),
    );
  }
}
