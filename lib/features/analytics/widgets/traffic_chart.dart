import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';
import 'package:growth_pilot_ai/core/models/traffic_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_chart_decorations.dart';

/// Flat bar chart for the Peak Hours Traffic widget (Issue #365): the
/// busiest bucket is highlighted in the theme's primary color, every
/// other bucket stays muted. See [TrafficChartDecorations] for the chrome.
class TrafficChart extends StatelessWidget {
  final List<TrafficPoint> points;
  final TrafficView view;

  const TrafficChart({super.key, required this.points, required this.view});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final maxY = points.map((p) => p.count).fold(0, (a, b) => a > b ? a : b);

    return SizedBox(
      height: 160,
      child: BarChart(BarChartData(
        maxY: maxY <= 0 ? 5 : maxY * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: TrafficChartDecorations.titles(view),
        barGroups: [
          for (final p in points)
            BarChartGroupData(x: p.bucket, barRods: [
              BarChartRodData(
                toY: p.count.toDouble(),
                color: p.isPeak
                    ? scheme.primary
                    : scheme.onSurface.withValues(alpha: 0.18),
                width: view == TrafficView.byHour ? 6 : 16,
                borderRadius: BorderRadius.circular(3),
              ),
            ]),
        ],
      )),
    );
  }
}
