import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_stock_take_variance.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders stock-take audit rows + a quick-add button (Issue #441). Purely
/// presentational — [StockTakeBody] owns the record list.
class StockTakeView extends StatelessWidget {
  final List<InventoryStockTakeEntity> records;
  final VoidCallback onAddRecord;

  const StockTakeView({super.key, required this.records, required this.onAddRecord});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final variances = ComputeStockTakeVariance.call(records);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('System vs. physical count reconciliation',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onAddRecord,
              child: Text('+ Stock Take', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (variances.isEmpty)
          const Text('No stock takes recorded yet.')
        else
          for (final v in variances) StockTakeRow(record: v),
      ],
    );
  }
}
