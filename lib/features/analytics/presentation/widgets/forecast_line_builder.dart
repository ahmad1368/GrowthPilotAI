import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Builds the dual-line series: a solid historical line plus a dashed forecast
/// line that begins exactly where the history ends. They share the pivot point
/// so the chart reads as one continuous "what happened → what might happen".
class ForecastLineBuilder {
  static List<LineChartBarData> build(
    List<double> historical,
    List<double> forecast,
    Color color,
  ) {
    final historicalSpots = <FlSpot>[
      for (int i = 0; i < historical.length; i++)
        FlSpot(i.toDouble(), historical[i]),
    ];
    final pivot = historical.length - 1;
    final forecastSpots = <FlSpot>[
      if (historical.isNotEmpty) FlSpot(pivot.toDouble(), historical.last),
      for (int i = 0; i < forecast.length; i++)
        FlSpot((pivot + 1 + i).toDouble(), forecast[i]),
    ];
    return [
      _line(historicalSpots, color, null),
      _line(forecastSpots, color.withValues(alpha: 0.6), const [6, 5]),
    ];
  }

  static LineChartBarData _line(
    List<FlSpot> spots,
    Color color,
    List<int>? dash,
  ) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      dashArray: dash,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: dash == null,
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.18), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
