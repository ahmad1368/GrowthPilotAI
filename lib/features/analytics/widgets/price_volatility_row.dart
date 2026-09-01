import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/price_volatility_alert.dart';

/// One product's latest price swing row (Issue #340).
class PriceVolatilityRow extends StatelessWidget {
  final PriceVolatilityAlert result;

  const PriceVolatilityRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = result.isBreached ? Colors.red : scheme.onSurface.withValues(alpha: 0.6);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (result.isBreached) Icon(Icons.warning_amber, size: 16, color: color),
          if (result.isBreached) const SizedBox(width: 6),
          Expanded(child: Text(result.productName, overflow: TextOverflow.ellipsis)),
          Text('\$${result.previousPrice.toStringAsFixed(2)} → \$${result.currentPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 8),
          Text('${result.changePercent >= 0 ? '+' : ''}${result.changePercent.toStringAsFixed(1)}%',
              style: TextStyle(fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}
