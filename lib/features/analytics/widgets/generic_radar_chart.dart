import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/chart_data_point.dart';

/// Renders any [ChartDataPoint] list as a radar (Issue #112): unlike
/// [BusinessRadarChart]'s fixed 5-axis "Success DNA" shape, the axes here
/// come entirely from whatever mapping produced [points], so the same
/// widget fits any category.
class GenericRadarChart extends StatelessWidget {
  final List<ChartDataPoint> points;

  const GenericRadarChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return AspectRatio(
      aspectRatio: 1,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          tickCount: 4,
          ticksTextStyle: const TextStyle(fontSize: 0, color: Colors.transparent),
          getTitle: (index, angle) =>
              RadarChartTitle(text: points[index].label, angle: angle),
          titleTextStyle: const TextStyle(fontSize: 11),
          dataSets: [
            RadarDataSet(
              fillColor: primary.withValues(alpha: 0.25),
              borderColor: primary,
              borderWidth: 2,
              dataEntries:
                  points.map((p) => RadarEntry(value: p.value)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
