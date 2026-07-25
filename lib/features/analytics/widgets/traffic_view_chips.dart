import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';

/// Hour-of-day / Day-of-week toggle for the Peak Hours Traffic widget
/// (Issue #365) — mirrors [MarginPeriodChips]'s pattern.
class TrafficViewChips extends StatelessWidget {
  final TrafficView selected;
  final ValueChanged<TrafficView> onChanged;

  const TrafficViewChips(
      {super.key, required this.selected, required this.onChanged});

  String _label(TrafficView view) => switch (view) {
        TrafficView.byHour => 'By Hour',
        TrafficView.byDayOfWeek => 'By Day',
      };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final view in TrafficView.values)
          ChoiceChip(
            label: Text(_label(view)),
            selected: selected == view,
            onSelected: (_) {
              HapticFeedback.selectionClick();
              onChanged(view);
            },
          ),
      ],
    );
  }
}
