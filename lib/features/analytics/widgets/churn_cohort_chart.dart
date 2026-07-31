import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/churn_cohort_point.dart';

/// Flat bar chart of the trailing weekly cohort trend (Issue #357), oldest
/// week on the left, this week on the right.
class ChurnCohortChart extends StatelessWidget {
  final List<ChurnCohortPoint> points;

  const ChurnCohortChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxY = points.map((p) => p.count).fold(0, (a, b) => a > b ? a : b);
    final lastIndex = points.length - 1;

    return SizedBox(
      height: 140,
      child: BarChart(BarChartData(
        maxY: maxY <= 0 ? 5 : maxY * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final weeksAgo = lastIndex - value.toInt();
                return Text(weeksAgo == 0 ? 'This wk' : '-${weeksAgo}w',
                    style: const TextStyle(fontSize: 9));
              },
            ),
          ),
        ),
        barGroups: [
          for (final p in points)
            BarChartGroupData(x: lastIndex - p.weeksAgo, barRods: [
              BarChartRodData(
                toY: p.count.toDouble(),
                color: scheme.primary,
                width: 12,
                borderRadius: BorderRadius.circular(3),
              ),
            ]),
        ],
      )),
    );
  }
}
