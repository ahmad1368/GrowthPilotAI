import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_item.dart';

/// Secondary detail lines under an inventory item's name (Issue #438):
/// category/serial/attributes on one line, expiry status on another when
/// the item is expiring soon or already expired.
class InventoryItemDetailSubtitle extends StatelessWidget {
  final InventoryStockItem item;

  const InventoryItemDetailSubtitle({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final mutedStyle =
        TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.5));
    final details = <String>[
      if (item.categoryPath != null) item.categoryPath!,
      if (item.vendorName != null) 'from ${item.vendorName}',
      if (item.serialNumber.isNotEmpty) 'SN: ${item.serialNumber}',
      for (final entry in item.attributes.entries) '${entry.key}: ${entry.value}',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (details.isNotEmpty)
          Text(details.join(' · '), overflow: TextOverflow.ellipsis, style: mutedStyle),
        if (item.expiryLabel != null)
          Text(item.expiryLabel!,
              style: TextStyle(fontSize: 11, color: scheme.error, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
