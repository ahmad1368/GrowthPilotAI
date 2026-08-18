import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/guess_requirement_stakeholder.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stakeholder "Manual Override" dropdown (Issue #229).
class StakeholderDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const StakeholderDropdown({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final options = GuessRequirementStakeholder.dropdownOptions.contains(value)
        ? GuessRequirementStakeholder.dropdownOptions
        : [value, ...GuessRequirementStakeholder.dropdownOptions];

    return DropdownButton<String>(
      value: value,
      underline: const SizedBox.shrink(),
      onChanged: (v) => v != null ? onChanged(v) : null,
      items: [
        for (final option in options)
          DropdownMenuItem(
            value: option,
            child: Text(option, style: TextStyle(color: colors.foreground, fontSize: 12)),
          ),
      ],
    );
  }
}
