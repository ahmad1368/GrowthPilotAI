import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_override_row.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_triage_actions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One candidate requirement card (Issue #228/#229): Confirm/Edit/
/// Reject + Manual Override dropdowns. Flat, no Glassmorphism.
class RequirementTriageCard extends StatelessWidget {
  final ExtractedRequirement requirement;
  final VoidCallback onConfirm;
  final VoidCallback onReject;
  final VoidCallback onEdit;
  final ValueChanged<RequirementMoscowPriority> onPriorityChanged;
  final ValueChanged<String> onStakeholderChanged;

  const RequirementTriageCard({
    super.key,
    required this.requirement,
    required this.onConfirm,
    required this.onReject,
    required this.onEdit,
    required this.onPriorityChanged,
    required this.onStakeholderChanged,
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
          Text('${requirement.type.name} · "${requirement.indicator}"',
              style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
          RequirementOverrideRow(
            priority: requirement.moscowPriority,
            stakeholder: requirement.stakeholder,
            onPriorityChanged: onPriorityChanged,
            onStakeholderChanged: onStakeholderChanged,
          ),
          const SizedBox(height: 8),
          RequirementTriageActions(onConfirm: onConfirm, onEdit: onEdit, onReject: onReject),
        ],
      ),
    );
  }
}
