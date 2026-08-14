import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Flat, minimal chart chrome for [ProfitMarginChart] (Issue #350): a
/// brighter zero-axis hairline so loss periods read clearly below the line.
class ProfitMarginChartDecorations {
  static FlGridData grid(Color fg) => FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (v) => FlLine(
            color: fg.withValues(alpha: v == 0 ? 0.3 : 0.08), strokeWidth: 1),
      );

  static const FlTitlesData titles = FlTitlesData(
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
  );
}
