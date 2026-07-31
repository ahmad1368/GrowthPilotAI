import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/product_bundle_recommendation.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One co-purchased item pair with its suggested bundle price
/// (Issue #378).
class ProductBundleRecommendationRow extends StatelessWidget {
  final ProductBundleRecommendation recommendation;

  const ProductBundleRecommendationRow({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${recommendation.itemA} + ${recommendation.itemB}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text('${recommendation.coOccurrenceCount}x together',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(recommendation.suggestedBundlePrice)),
        ],
      ),
    );
  }
}
