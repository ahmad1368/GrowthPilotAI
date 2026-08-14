import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Sale/return direction picker for a new stock movement (Issue #439).
class StockMovementTypeSelect extends StatelessWidget {
  final StockMovementType type;
  final ValueChanged<StockMovementType?> onChanged;

  const StockMovementTypeSelect({super.key, required this.type, required this.onChanged});

  static String _label(StockMovementType t) => t == StockMovementType.sale ? 'Sale' : 'Return';

  @override
  Widget build(BuildContext context) {
    return ShadSelect<StockMovementType>(
      initialValue: type,
      placeholder: const Text('Movement type'),
      options: [
        for (final t in StockMovementType.values) ShadOption(value: t, child: Text(_label(t)))
      ],
      selectedOptionBuilder: (context, value) => Text(_label(value)),
      onChanged: onChanged,
    );
  }
}
