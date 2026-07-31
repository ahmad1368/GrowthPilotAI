import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/basket_optimization_snapshot.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One item's basket-optimization row (Issue #390).
class BasketOptimizationRow extends StatelessWidget {
  final BasketOptimizationSnapshot snapshot;

  const BasketOptimizationRow({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final actionColor = snapshot.shortfallQuantity > 0
        ? scheme.primary
        : (snapshot.excessQuantity > 0 ? scheme.error : scheme.onSurface);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(snapshot.item.name, overflow: TextOverflow.ellipsis)),
          Text('ideal ${snapshot.idealQuantity}',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(snapshot.holdingCostExposure)),
          const SizedBox(width: 8),
          Text(snapshot.recommendedAction,
              style: TextStyle(fontSize: 11, color: actionColor)),
        ],
      ),
    );
  }
}
