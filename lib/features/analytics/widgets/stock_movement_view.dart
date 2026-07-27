import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/sort_stock_movements.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders stock-movement rows + a record-movement button (Issue #439).
/// Purely presentational — [StockMovementBody] owns the movement list.
class StockMovementView extends StatelessWidget {
  final List<StockMovementEntity> movements;
  final VoidCallback onRecordMovement;

  const StockMovementView({super.key, required this.movements, required this.onRecordMovement});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final sorted = SortStockMovements.call(movements);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Sales and returns adjust stock instantly',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onRecordMovement,
              child: Text('+ Record Movement', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (sorted.isEmpty)
          const Text('No stock movements recorded yet.')
        else
          for (final m in sorted) StockMovementRow(movement: m),
      ],
    );
  }
}
