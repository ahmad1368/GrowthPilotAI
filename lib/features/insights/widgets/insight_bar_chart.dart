import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/daily_total_point.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Line/Bar Chart view for a time-spanning query (Issue #261) — flat
/// primary-accent bars via fl_chart (already a repo dependency), not the
/// issue's literal glassmorphism background.
class InsightBarChart extends StatelessWidget {
  final List<DailyTotalPoint> points;

  const InsightBarChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final maxY = points.map((p) => p.total).fold(0.0, (a, b) => a > b ? a : b);

    return SizedBox(
      height: 160,
      child: BarChart(BarChartData(
        maxY: maxY <= 0 ? 1 : maxY * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        barGroups: [
          for (var i = 0; i < points.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: points[i].total,
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
