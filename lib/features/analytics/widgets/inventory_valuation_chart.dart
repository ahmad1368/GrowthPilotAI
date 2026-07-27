import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/inventory_valuation_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_chart_decorations.dart';

/// Flat cumulative-investment trend line (Issue #446), no glow/blur — see
/// [InventoryValuationChartDecorations] for the chrome.
class InventoryValuationChart extends StatelessWidget {
  final List<InventoryValuationPoint> points;

  const InventoryValuationChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (points.length < 2) {
      return const SizedBox(
          height: 140, child: Center(child: Text('Record more layers to see a trend')));
    }
    final spots = [
      for (var i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].cumulativeValue),
    ];

    return SizedBox(
      height: 140,
      child: LineChart(LineChartData(
        minY: 0,
        gridData: InventoryValuationChartDecorations.grid(scheme.onSurface),
        titlesData: InventoryValuationChartDecorations.titles,
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: scheme.primary,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData:
                BarAreaData(show: true, color: scheme.primary.withValues(alpha: 0.12)),
          ),
        ],
      )),
    );
  }
}
