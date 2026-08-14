import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/profit_margin_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_chart_decorations.dart';

/// Flat trend line for the Profit Margin Analysis widget (Issue #350), no
/// glow/blur — see [ProfitMarginChartDecorations] for the chrome.
class ProfitMarginChart extends StatelessWidget {
  final List<ProfitMarginPoint> points;

  const ProfitMarginChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (points.isEmpty) {
      return const SizedBox(
          height: 160, child: Center(child: Text('No transactions yet')));
    }
    final spots = [
      for (var i = 0; i < points.length; i++)
        FlSpot(i.toDouble(), points[i].marginPercent),
    ];
    final maxAbs =
        points.map((p) => p.marginPercent.abs()).reduce((a, b) => a > b ? a : b);
    final bound = maxAbs < 10 ? 10.0 : maxAbs * 1.2;

    return SizedBox(
      height: 160,
      child: LineChart(LineChartData(
        minY: -bound,
        maxY: bound,
        gridData: ProfitMarginChartDecorations.grid(scheme.onSurface),
        titlesData: ProfitMarginChartDecorations.titles,
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: scheme.primary,
            barWidth: 2,
            dotData: const FlDotData(show: true),
            belowBarData:
                BarAreaData(show: true, color: scheme.primary.withValues(alpha: 0.12)),
          ),
        ],
      )),
    );
  }
}
