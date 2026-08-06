import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_price_intelligence_narrative.dart';
import 'package:growth_pilot_ai/core/enum/price_deal_tier.dart';
import 'package:growth_pilot_ai/core/models/price_trend_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_deal_badge.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_trend_chart.dart';

/// Renders the Fair Price Index result: baseline price, deal badge,
/// narrative, and trend chart (Issue #416, acceptance criteria 2-4).
class PriceIntelligenceResult extends StatelessWidget {
  final double averagePrice;
  final int sampleCount;
  final double fairPriceIndex;
  final PriceDealTier tier;
  final List<PriceTrendPoint> trendPoints;

  const PriceIntelligenceResult({
    super.key,
    required this.averagePrice,
    required this.sampleCount,
    required this.fairPriceIndex,
    required this.tier,
    required this.trendPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(children: [
          Text('Regional baseline: \$${averagePrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          PriceDealBadge(tier: tier),
        ]),
        const SizedBox(height: 4),
        Text(BuildPriceIntelligenceNarrative.call(sampleCount, fairPriceIndex, tier),
            style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        PriceTrendChart(points: trendPoints),
      ],
    );
  }
}
