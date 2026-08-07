import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/inventory_recommendation.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_recommendation_confidence_badge.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One restocking recommendation card (Issue #418) — forecast,
/// matched listing, budget/storage fit flags, confidence, and
/// requisition/dismiss actions.
class InventoryRecommendationRow extends StatelessWidget {
  final InventoryRecommendation recommendation;
  final double confidence;
  final VoidCallback onRequisition;
  final VoidCallback onDismiss;

  const InventoryRecommendationRow({
    super.key,
    required this.recommendation,
    required this.confidence,
    required this.onRequisition,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final forecast = recommendation.forecast;
    final listing = recommendation.matchedListing;
    final days = forecast.daysUntilStockout?.toStringAsFixed(0) ?? '?';
    final canRequisition =
        listing != null && recommendation.fitsBudget && recommendation.fitsStorage;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${forecast.item.name} — ~$days day(s) until stockout'),
          Text(
              listing == null
                  ? 'No marketplace listing available yet'
                  : '${listing.quantityListed}x from marketplace @ \$${listing.wholesalePrice.toStringAsFixed(2)}/unit'
                      '${recommendation.fitsBudget ? '' : ' — exceeds budget'}'
                      '${recommendation.fitsStorage ? '' : ' — exceeds storage capacity'}',
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Row(children: [
            InventoryRecommendationConfidenceBadge(confidence: confidence),
            const Spacer(),
            if (canRequisition)
              ShadButton.ghost(onPressed: onRequisition, child: const Text('Requisition')),
            ShadButton.ghost(onPressed: onDismiss, child: const Text('Dismiss')),
          ]),
        ],
      ),
    );
  }
}
