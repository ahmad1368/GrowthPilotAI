import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/enum/traffic_day_part.dart';

/// Filters the heatmap grid to a single day-part band, or all of them
/// (Issue #354) — mirrors [TrafficViewChips]'s pattern.
class TrafficHeatmapDayPartChips extends StatelessWidget {
  final TrafficDayPart? selected;
  final ValueChanged<TrafficDayPart?> onChanged;

  const TrafficHeatmapDayPartChips(
      {super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ChoiceChip(
          label: const Text('All'),
          selected: selected == null,
          onSelected: (_) {
            HapticFeedback.selectionClick();
            onChanged(null);
          },
        ),
        for (final part in TrafficDayPart.values)
          ChoiceChip(
            label: Text(part.label),
            selected: selected == part,
            onSelected: (_) {
              HapticFeedback.selectionClick();
              onChanged(part);
            },
          ),
      ],
    );
  }
}
