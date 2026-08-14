import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Lookback-window picker for turnover calculations (Issue #447).
class InventoryTurnoverAgingPeriodSelect extends StatelessWidget {
  final TurnoverPeriod period;
  final ValueChanged<TurnoverPeriod?> onChanged;

  const InventoryTurnoverAgingPeriodSelect(
      {super.key, required this.period, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ShadSelect<TurnoverPeriod>(
      initialValue: period,
      placeholder: const Text('Period'),
      options: [
        for (final p in TurnoverPeriod.values)
          ShadOption(value: p, child: Text(p.label))
      ],
      selectedOptionBuilder: (context, value) => Text(value.label),
      onChanged: onChanged,
    );
  }
}
