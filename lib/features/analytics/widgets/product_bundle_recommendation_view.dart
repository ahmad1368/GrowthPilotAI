import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/product_bundle_recommendation.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/product_bundle_recommendation_row.dart';

/// Renders the top co-purchased item pairs, or an empty state (Issue #378).
class ProductBundleRecommendationView extends StatelessWidget {
  final List<ProductBundleRecommendation> recommendations;

  const ProductBundleRecommendationView({super.key, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return const Text(
          'Not enough co-purchase history yet to suggest bundles.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final recommendation in recommendations)
          ProductBundleRecommendationRow(recommendation: recommendation),
      ],
    );
  }
}
