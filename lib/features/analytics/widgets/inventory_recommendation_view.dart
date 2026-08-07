import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_inventory_recommendation_narrative.dart';
import 'package:growth_pilot_ai/core/models/inventory_recommendation.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_recommendation_row.dart';

/// Renders every open recommendation and a summary narrative (Issue
/// #418). Purely presentational.
class InventoryRecommendationView extends StatelessWidget {
  final List<InventoryRecommendation> recommendations;
  final double Function(String itemName) confidenceFor;
  final void Function(InventoryRecommendation) onRequisition;
  final void Function(InventoryRecommendation) onDismiss;

  const InventoryRecommendationView({
    super.key,
    required this.recommendations,
    required this.confidenceFor,
    required this.onRequisition,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final recommendation in recommendations)
          InventoryRecommendationRow(
            recommendation: recommendation,
            confidence: confidenceFor(recommendation.forecast.item.name),
            onRequisition: () => onRequisition(recommendation),
            onDismiss: () => onDismiss(recommendation),
          ),
        const SizedBox(height: 8),
        Text(BuildInventoryRecommendationNarrative.call(recommendations)),
      ],
    );
  }
}
