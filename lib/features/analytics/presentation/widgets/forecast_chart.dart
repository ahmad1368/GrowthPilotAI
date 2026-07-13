import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'forecast_chart_decorations.dart';
import 'forecast_line_builder.dart';

/// Dual-line spending forecast chart: a solid historical trend flowing into a
/// dashed prediction. Flat/minimal styling; colors follow the active theme's
/// foreground (expense = error color, income = primary). Y-axis auto-scales to
/// the largest value across both the real and predicted series.
class ForecastChart extends StatelessWidget {
  final List<double> historical;
  final List<double> forecast;
  final bool isExpense;

  const ForecastChart({
    super.key,
    required this.historical,
    required this.forecast,
    this.isExpense = true,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = isExpense ? scheme.error : scheme.primary;
    final all = [...historical, ...forecast];
    final maxY =
        all.isEmpty ? 10.0 : all.reduce((a, b) => a > b ? a : b) * 1.2;

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY,
        gridData: ForecastChartDecorations.grid(scheme.onSurface),
        titlesData: ForecastChartDecorations.titles,
        borderData: FlBorderData(show: false),
        lineTouchData:
            ForecastChartDecorations.touch(scheme.surface, scheme.onSurface),
        lineBarsData: ForecastLineBuilder.build(historical, forecast, color),
      ),
    );
  }
}
