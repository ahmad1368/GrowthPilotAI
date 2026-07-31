import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/competitor_price_gap.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One logged competitor price gap row (Issue #351).
class CompetitorPriceRow extends StatelessWidget {
  final CompetitorPriceGap result;

  const CompetitorPriceRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(result.productName, overflow: TextOverflow.ellipsis)),
          Text(result.competitorName,
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(result.ourPrice),
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Text(
            '${result.gapPercent.toStringAsFixed(1)}%',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: result.isPricedAboveCompetitor
                    ? scheme.error
                    : scheme.primary),
          ),
        ],
      ),
    );
  }
}
