import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/exchange_rate_impact.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One logged FX observation's landed-cost impact row (Issue #371).
class ExchangeRateRow extends StatelessWidget {
  final ExchangeRateImpact result;

  const ExchangeRateRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(result.productName, overflow: TextOverflow.ellipsis)),
          Text(result.currencyPair,
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(result.landedCostCurrent),
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Text(
            '${result.costImpactPercent.toStringAsFixed(1)}%',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color:
                    result.costIncreased ? scheme.error : scheme.primary),
          ),
        ],
      ),
    );
  }
}
