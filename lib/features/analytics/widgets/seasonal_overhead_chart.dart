import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/seasonal_overhead_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_overhead_chart_decorations.dart';

/// Flat 12-month bar chart for the Seasonal Overhead widget (Issue #386):
/// the peak-cost month's bar is highlighted in the theme's error color,
/// every other month stays muted.
class SeasonalOverheadChart extends StatelessWidget {
  final List<SeasonalOverheadPoint> points;

  const SeasonalOverheadChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxY =
        points.map((p) => p.averageExpense).fold(0.0, (a, b) => a > b ? a : b);

    return SizedBox(
      height: 160,
      child: BarChart(BarChartData(
        maxY: maxY <= 0 ? 10 : maxY * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: SeasonalOverheadChartDecorations.titles,
        barGroups: [
          for (final p in points)
            BarChartGroupData(x: p.month - 1, barRods: [
              BarChartRodData(
                toY: p.averageExpense,
                color: p.isPeak
                    ? scheme.error
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
