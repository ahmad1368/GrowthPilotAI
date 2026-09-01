import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/dead_stock_liquidation_snapshot.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One dead-stock item's liquidation row (Issue #370).
class DeadStockLiquidationRow extends StatelessWidget {
  final DeadStockLiquidationSnapshot snapshot;

  const DeadStockLiquidationRow({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(snapshot.item.name, overflow: TextOverflow.ellipsis)),
          Text('${snapshot.agingDays}d aging',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(snapshot.tiedUpCapital)),
          const SizedBox(width: 8),
          Text(snapshot.suggestedChannel,
              style: TextStyle(fontSize: 11, color: scheme.error)),
        ],
      ),
    );
  }
}
