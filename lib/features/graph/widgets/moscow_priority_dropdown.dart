import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';

/// Color-coded MoSCoW priority dropdown (Issue #229's AC: "color-coded
/// chips" + "every field must be a dropdown... Manual Override") — one
/// widget satisfies both ACs at once.
class MoscowPriorityDropdown extends StatelessWidget {
  final RequirementMoscowPriority value;
  final ValueChanged<RequirementMoscowPriority> onChanged;

  const MoscowPriorityDropdown({super.key, required this.value, required this.onChanged});

  static Color colorFor(RequirementMoscowPriority priority) => switch (priority) {
        RequirementMoscowPriority.mustHave => Colors.red,
        RequirementMoscowPriority.shouldHave => Colors.orange,
        RequirementMoscowPriority.couldHave => Colors.blue,
        RequirementMoscowPriority.wontHave => Colors.grey,
      };

  static String labelFor(RequirementMoscowPriority priority) => switch (priority) {
        RequirementMoscowPriority.mustHave => 'Must-Have',
        RequirementMoscowPriority.shouldHave => 'Should-Have',
        RequirementMoscowPriority.couldHave => 'Could-Have',
        RequirementMoscowPriority.wontHave => "Won't-Have",
      };

  @override
  Widget build(BuildContext context) {
    return DropdownButton<RequirementMoscowPriority>(
      value: value,
      underline: const SizedBox.shrink(),
      onChanged: (v) => v != null ? onChanged(v) : null,
      items: [
        for (final priority in RequirementMoscowPriority.values)
          DropdownMenuItem(
            value: priority,
            child: Text(labelFor(priority),
                style: TextStyle(color: colorFor(priority), fontWeight: FontWeight.w600, fontSize: 12)),
          ),
      ],
    );
  }
}
