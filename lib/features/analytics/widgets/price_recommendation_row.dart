import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/price_recommendation.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One item's suggested price adjustment (Issue #356).
class PriceRecommendationRow extends StatelessWidget {
  final PriceRecommendation recommendation;

  const PriceRecommendationRow({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = recommendation.priceChangePercent > 0
        ? scheme.primary
        : (recommendation.priceChangePercent < 0 ? scheme.error : scheme.onSurface);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(recommendation.item.name, overflow: TextOverflow.ellipsis)),
          Text(CurrencyFormat.cad(recommendation.suggestedPrice),
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 12),
          Text(
            '${recommendation.priceChangePercent >= 0 ? '+' : ''}'
            '${recommendation.priceChangePercent.toStringAsFixed(0)}%',
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
