import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';

/// Daily/Weekly/Monthly toggle for the Profit Margin widget (Issue #350) —
/// mirrors [CompassPeriodChips]'s pattern.
class MarginPeriodChips extends StatelessWidget {
  final MarginPeriod selected;
  final ValueChanged<MarginPeriod> onChanged;

  const MarginPeriodChips(
      {super.key, required this.selected, required this.onChanged});

  String _label(MarginPeriod period) => switch (period) {
        MarginPeriod.daily => 'Daily',
        MarginPeriod.weekly => 'Weekly',
        MarginPeriod.monthly => 'Monthly',
      };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final period in MarginPeriod.values)
          ChoiceChip(
            label: Text(_label(period)),
            selected: selected == period,
            onSelected: (_) {
              HapticFeedback.selectionClick();
              onChanged(period);
            },
          ),
      ],
    );
  }
}
