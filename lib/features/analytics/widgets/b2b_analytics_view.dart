import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/b2b_sector_saturation_chart.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/build_b2b_analytics_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_trend_line_chart.dart';

/// Pure rendering of the B2B Intelligence Hub summary (Issue #129) —
/// flat rows, not the issue's literal Glassmorphism ask.
class B2bAnalyticsView extends StatelessWidget {
  final B2bAnalyticsSummary summary;

  const B2bAnalyticsView({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final f = summary.funnel;
    final leadHours = summary.averageLeadTime.inMinutes / 60;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Sector Saturation', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      B2bSectorSaturationChart(data: summary.sectorSaturation),
      const SizedBox(height: 8),
      Text('Funnel: ${f.broadcast} broadcast -> ${f.negotiating} negotiating -> ${f.matched} matched',
          style: const TextStyle(fontSize: 12)),
      Text('Avg. lead time to first response: ${leadHours.toStringAsFixed(1)}h',
          style: const TextStyle(fontSize: 12)),
      Text('Forecasted demand next week: ${summary.nextWeekDemandForecast.toStringAsFixed(1)} requests',
          style: const TextStyle(fontSize: 12)),
      const SizedBox(height: 8),
      const Text('Liquidity by Neighborhood', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      for (final row in summary.liquidityHeatmap)
        Text('${row.neighborhood}: ${row.active} active, ${row.completed} completed',
            style: const TextStyle(fontSize: 11)),
      const SizedBox(height: 8),
      const Text('Regional Price Volatility (std. dev.)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      for (final row in summary.priceVolatility)
        Text('${row.neighborhood}: \$${row.stdDev.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11)),
      const SizedBox(height: 8),
      const Text('Price Trend (30d)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      PriceTrendLineChart(points: summary.priceTrendLine),
      if (summary.trendingSectorNarratives.isNotEmpty) ...[
        const SizedBox(height: 8),
        const Text('Trending', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        for (final narrative in summary.trendingSectorNarratives)
          Text(narrative, style: const TextStyle(fontSize: 11)),
      ],
    ]);
  }
}
