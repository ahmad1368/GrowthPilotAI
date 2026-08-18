import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/features/graph/widgets/moscow_priority_dropdown.dart';
import 'package:growth_pilot_ai/features/graph/widgets/stakeholder_dropdown.dart';

/// The "Manual Override" row (Issue #229) — priority + stakeholder
/// dropdowns side by side.
class RequirementOverrideRow extends StatelessWidget {
  final RequirementMoscowPriority priority;
  final String stakeholder;
  final ValueChanged<RequirementMoscowPriority> onPriorityChanged;
  final ValueChanged<String> onStakeholderChanged;

  const RequirementOverrideRow({
    super.key,
    required this.priority,
    required this.stakeholder,
    required this.onPriorityChanged,
    required this.onStakeholderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MoscowPriorityDropdown(value: priority, onChanged: onPriorityChanged),
        const SizedBox(width: 12),
        StakeholderDropdown(value: stakeholder, onChanged: onStakeholderChanged),
      ],
    );
  }
}
