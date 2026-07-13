import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Flat, minimal chart chrome (grid / axes / tooltip) aligned to the active
/// theme's foreground. No glassmorphism — just a faint hairline grid.
class ForecastChartDecorations {
  static FlGridData grid(Color line) => FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (v) =>
            FlLine(color: line.withValues(alpha: 0.08), strokeWidth: 1),
      );

  static const FlTitlesData titles = FlTitlesData(
    show: true,
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true, reservedSize: 44)),
    bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
  );

  static LineTouchData touch(Color bg, Color fg) => LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: bg,
          getTooltipItems: (spots) => spots
              .map((s) => LineTooltipItem(
                    CurrencyFormat.cad(s.y),
                    TextStyle(color: fg, fontWeight: FontWeight.w600),
                  ))
              .toList(),
        ),
      );
}
