import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/price_recommendation.dart';
import 'package:growth_pilot_ai/core/models/turnover_period.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_period_select.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_recommendation_row.dart';

/// Renders the period picker and per-item price recommendation rows
/// (Issue #356).
class PriceRecommendationView extends StatelessWidget {
  final TurnoverPeriod period;
  final ValueChanged<TurnoverPeriod?> onPeriodChanged;
  final List<PriceRecommendation> recommendations;

  const PriceRecommendationView({
    super.key,
    required this.period,
    required this.onPeriodChanged,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InventoryTurnoverAgingPeriodSelect(
                period: period, onChanged: onPeriodChanged),
          ],
        ),
        const SizedBox(height: 8),
        if (recommendations.isEmpty)
          const Text('No inventory items to price.')
        else
          for (final recommendation in recommendations)
            PriceRecommendationRow(recommendation: recommendation),
      ],
    );
  }
}
