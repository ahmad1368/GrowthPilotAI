import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/enum/compass_period.dart';

/// Monthly/Quarterly/Annual toggle for the Business Compass (Issue #84) —
/// mirrors [WindowSelectorChips]'s pattern.
class CompassPeriodChips extends StatelessWidget {
  final CompassPeriod selected;
  final ValueChanged<CompassPeriod> onChanged;

  const CompassPeriodChips(
      {super.key, required this.selected, required this.onChanged});

  String _label(CompassPeriod period) {
    switch (period) {
      case CompassPeriod.monthly:
        return 'Monthly';
      case CompassPeriod.quarterly:
        return 'Quarterly';
      case CompassPeriod.annual:
        return 'Annual';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final period in CompassPeriod.values)
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
