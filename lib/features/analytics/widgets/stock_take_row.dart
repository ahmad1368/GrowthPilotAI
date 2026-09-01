import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_take_record.dart';

/// One stock-take audit row (Issue #441): system vs. physical count, with
/// the variance colored red for shrinkage and primary for a clean count.
class StockTakeRow extends StatelessWidget {
  final InventoryStockTakeRecord record;

  const StockTakeRow({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = record.hasDiscrepancy ? scheme.error : scheme.primary;
    final varianceLabel = record.variance > 0 ? '+${record.variance}' : '${record.variance}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('${record.itemName} (${record.systemQuantity} → ${record.physicalQuantity})',
                overflow: TextOverflow.ellipsis),
          ),
          Text(varianceLabel, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
