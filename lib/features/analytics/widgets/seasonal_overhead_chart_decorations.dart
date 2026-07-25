import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/seasonal_overhead_point.dart';

/// Flat, minimal chart chrome for [SeasonalOverheadChart] (Issue #386):
/// only a month-abbreviation X axis, mirroring [SeasonalDemandChartDecorations].
class SeasonalOverheadChartDecorations {
  static FlTitlesData get titles => FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(
              SeasonalOverheadPoint.monthLabels[value.toInt()],
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      );
}
