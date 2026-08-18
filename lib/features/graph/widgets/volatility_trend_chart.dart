import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Trend Chart: a Spline Area chart to visualize 'Requirement
/// Volatility' over time" (Issue #234) — plots every KPI recompute
/// within the current session; no persisted long-term history exists
/// (see PR notes).
class VolatilityTrendChart extends StatelessWidget {
  final List<ProjectMetricsSnapshot> history;

  const VolatilityTrendChart({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    if (history.length < 2) {
      return Text('Not enough history yet — analyze more documents to see a trend.',
          style: TextStyle(color: colors.mutedForeground, fontSize: 12));
    }
    return SizedBox(
      height: 140,
      child: LineChart(LineChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        minY: 0,
        maxY: 1,
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: colors.primary,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: colors.primary.withValues(alpha: 0.15)),
            spots: [
              for (var i = 0; i < history.length; i++)
                FlSpot(i.toDouble(), history[i].volatilityRate),
            ],
          ),
        ],
      )),
    );
  }
}
