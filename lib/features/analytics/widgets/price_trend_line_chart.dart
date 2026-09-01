import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// "Price Trend Lines" (Issue #148) — flat line chart, not the issue's
/// literal Glassmorphism "frosted-glass" ask (architecture forbids
/// Glassmorphism/BackdropFilter).
class PriceTrendLineChart extends StatelessWidget {
  final List<({DateTime day, double avgBudget})> points;

  const PriceTrendLineChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return const Text('Not enough data yet for a price trend',
          style: TextStyle(fontSize: 12));
    }
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 120,
      // Issue #110 "Raster Cache Optimization": this line only changes
      // when [points] does, so isolate it in its own raster layer to skip
      // GPU redraw on ancestor rebuilds.
      child: RepaintBoundary(
        child: LineChart(LineChartData(
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: scheme.primary,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              spots: [
                for (var i = 0; i < points.length; i++)
                  FlSpot(i.toDouble(), points[i].avgBudget),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
