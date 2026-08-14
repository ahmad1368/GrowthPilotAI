import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/price_trend_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_trend_chart_decorations.dart';

/// Flat historical price trend line for a queried SKU (Issue #416,
/// acceptance criterion 4), mirroring [ProfitMarginChart].
class PriceTrendChart extends StatelessWidget {
  final List<PriceTrendPoint> points;

  const PriceTrendChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (points.length < 2) {
      return const SizedBox(height: 120, child: Center(child: Text('Not enough history yet')));
    }
    final spots = [
      for (var i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].price),
    ];
    return SizedBox(
      height: 120,
      child: LineChart(LineChartData(
        gridData: PriceTrendChartDecorations.grid(scheme.onSurface),
        titlesData: PriceTrendChartDecorations.titles,
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: scheme.primary,
            barWidth: 2,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: scheme.primary.withValues(alpha: 0.12)),
          ),
        ],
      )),
    );
  }
}
