import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/item_valuation.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One item's row in the valuation summary table (Issue #446): name,
/// quantity on hand, and total value under the selected method.
class InventoryValuationRow extends StatelessWidget {
  final ItemValuation valuation;

  const InventoryValuationRow({super.key, required this.valuation});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(valuation.item.name, overflow: TextOverflow.ellipsis)),
          Text('× ${valuation.item.quantityOnHand}',
              style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(valuation.totalValue)),
        ],
      ),
    );
  }
}
