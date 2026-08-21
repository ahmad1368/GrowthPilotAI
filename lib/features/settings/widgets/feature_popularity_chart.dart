import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "A bar chart comparing the frequency of use for each major module"
/// (Issue #194) — flat primary-accent bars via fl_chart, matching this
/// repo's existing #261 `InsightBarChart` precedent.
class FeaturePopularityChart extends StatelessWidget {
  final List<({String label, int count})> entries;

  const FeaturePopularityChart({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final maxY = entries.map((e) => e.count).fold(0, (a, b) => a > b ? a : b).toDouble();

    return SizedBox(
      height: 160,
      child: BarChart(BarChartData(
        maxY: maxY <= 0 ? 1 : maxY * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        barGroups: [
          for (var i = 0; i < entries.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: entries[i].count.toDouble(),
                color: colors.primary,
                width: 12,
                borderRadius: BorderRadius.circular(3),
              ),
            ]),
        ],
      )),
    );
  }
}
