import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/seasonal_demand_point.dart';

/// Flat, minimal chart chrome for [SeasonalDemandChart] (Issue #352): only
/// a month-abbreviation X axis, no grid/Y labels — the bar heights and the
/// highlighted peak already tell the story.
class SeasonalDemandChartDecorations {
  static FlTitlesData get titles => FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(
              SeasonalDemandPoint.monthLabels[value.toInt()],
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      );
}
