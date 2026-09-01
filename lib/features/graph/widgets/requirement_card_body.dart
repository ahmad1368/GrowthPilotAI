import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_override_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Description + type/indicator + Manual Override row for one triage
/// card (split out of [RequirementTriageCard] to keep it under the
/// 50-line-per-file guideline).
class RequirementCardBody extends StatelessWidget {
  final ExtractedRequirement requirement;
  final ValueChanged<RequirementMoscowPriority> onPriorityChanged;
  final ValueChanged<String> onStakeholderChanged;

  const RequirementCardBody({
    super.key,
    required this.requirement,
    required this.onPriorityChanged,
    required this.onStakeholderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Column(
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
      ],
    );
  }
}
