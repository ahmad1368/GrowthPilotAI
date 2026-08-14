import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/seasonal_demand_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_demand_chart_decorations.dart';

/// Flat 12-month bar chart for the Seasonal Demand widget (Issue #352): the
/// peak month's bar is highlighted in the theme's primary color, every
/// other month stays muted. See [SeasonalDemandChartDecorations] for chrome.
class SeasonalDemandChart extends StatelessWidget {
  final List<SeasonalDemandPoint> points;

  const SeasonalDemandChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxY =
        points.map((p) => p.averageRevenue).fold(0.0, (a, b) => a > b ? a : b);

    return SizedBox(
      height: 160,
      child: BarChart(BarChartData(
        maxY: maxY <= 0 ? 10 : maxY * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: SeasonalDemandChartDecorations.titles,
        barGroups: [
          for (final p in points)
            BarChartGroupData(x: p.month - 1, barRods: [
              BarChartRodData(
                toY: p.averageRevenue,
                color: p.isPeak
                    ? scheme.primary
                    : scheme.onSurface.withValues(alpha: 0.18),
                width: 12,
                borderRadius: BorderRadius.circular(3),
              ),
            ]),
        ],
      )),
    );
  }
}
