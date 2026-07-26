import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_item.dart';

/// One inventory item's stock row (Issue #435): a low-stock warning icon
/// and a quantity readout, colored by stock status.
class InventoryItemRow extends StatelessWidget {
  final InventoryStockItem item;

  const InventoryItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isLow = item.status == InventoryStockStatus.lowStock;
    final color = isLow ? scheme.error : scheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                if (isLow) ...[
                  Icon(Icons.warning_amber_rounded, size: 14, color: color),
                  const SizedBox(width: 4),
                ],
                Flexible(child: Text(item.name, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Text('${item.quantityOnHand} on hand',
              style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
