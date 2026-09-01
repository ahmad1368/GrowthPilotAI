import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/traceability_quick_filter.dart';

/// "Quick Filter Chips: 'Gaps Only', 'Untested Reqs', 'High Priority'"
/// (Issue #239).
class TraceabilityQuickFilterChips extends StatelessWidget {
  final TraceabilityQuickFilter? value;
  final ValueChanged<TraceabilityQuickFilter?> onChanged;

  const TraceabilityQuickFilterChips({super.key, required this.value, required this.onChanged});

  static const _labels = {
    TraceabilityQuickFilter.gapsOnly: 'Gaps Only',
    TraceabilityQuickFilter.untestedReqs: 'Untested Reqs',
    TraceabilityQuickFilter.highPriority: 'High Priority',
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final filter in TraceabilityQuickFilter.values)
          ChoiceChip(
            label: Text(_labels[filter]!),
            selected: value == filter,
            onSelected: (selected) => onChanged(selected ? filter : null),
          ),
      ],
    );
  }
}
