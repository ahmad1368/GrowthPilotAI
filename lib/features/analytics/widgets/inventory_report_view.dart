import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_inventory_stock_status.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the inventory stock rows + a quick-add button (Issue #435).
/// Purely presentational — [InventoryReportBody] owns the item list.
class InventoryReportView extends StatelessWidget {
  final List<InventoryItemEntity> items;
  final VoidCallback onAddItem;

  const InventoryReportView({super.key, required this.items, required this.onAddItem});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final stockItems = ComputeInventoryStockStatus.call(items);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Stock on hand vs. reorder threshold',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onAddItem,
              child: Text('+ Add Item', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (stockItems.isEmpty)
          const Text('No inventory items tracked yet.')
        else
          for (final item in stockItems) InventoryItemRow(item: item),
      ],
    );
  }
}
