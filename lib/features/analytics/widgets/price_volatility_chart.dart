import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/price_volatility_alert.dart';

/// Comparative volatility bar chart across products (Issue #340,
/// acceptance criterion 3) — bar height is the absolute swing percent,
/// colored red when it breached the threshold.
class PriceVolatilityChart extends StatelessWidget {
  final List<PriceVolatilityAlert> results;

  const PriceVolatilityChart({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final shown = results.take(6).toList();
    final maxY = shown.map((r) => r.changePercent.abs()).fold(0.0, (a, b) => a > b ? a : b);

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
                final i = value.toInt();
                if (i < 0 || i >= shown.length) return const SizedBox.shrink();
                return Text(shown[i].productName,
                    style: const TextStyle(fontSize: 9), overflow: TextOverflow.ellipsis);
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < shown.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: shown[i].changePercent.abs(),
                color: shown[i].isBreached ? Colors.red : scheme.primary,
                width: 16,
                borderRadius: BorderRadius.circular(3),
              ),
            ]),
        ],
      )),
    );
  }
}
