import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/monthly_impact_point.dart';

/// Comparative before/after impact chart across months (Issue #349,
/// acceptance criteria 1-2) — bars above zero read as merchants
/// retaining more after admin adjustments that month, below zero less.
class ImpactAnalysisChart extends StatelessWidget {
  final List<MonthlyImpactPoint> points;

  const ImpactAnalysisChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxAbs =
        points.map((p) => p.averageImpactPercent.abs()).fold(0.0, (a, b) => a > b ? a : b);

    return SizedBox(
      height: 140,
      child: BarChart(BarChartData(
        maxY: maxAbs <= 0 ? 5 : maxAbs * 1.2,
        minY: maxAbs <= 0 ? -5 : -maxAbs * 1.2,
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
                final i = value.toInt();
                if (i < 0 || i >= points.length) return const SizedBox.shrink();
                return Text(points[i].monthLabel, style: const TextStyle(fontSize: 9));
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < points.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: points[i].averageImpactPercent,
                color: points[i].averageImpactPercent >= 0 ? scheme.primary : Colors.red,
                width: 16,
                borderRadius: BorderRadius.circular(3),
              ),
            ]),
        ],
      )),
    );
  }
}
