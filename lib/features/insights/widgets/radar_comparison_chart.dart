import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/chart_data_point.dart';
import 'package:growth_pilot_ai/features/insights/widgets/radar_chart_painter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Market Comparison" radar chart (Issue #99) — a flat card, not the
/// issue's literal Glassmorphism/frosted-glass ask (architecture forbids
/// Glassmorphism/BackdropFilter). Shows an empty state when [axes] has
/// no data points instead of an unreadable blank polygon (AC:
/// "handles Empty States gracefully").
class RadarComparisonChart extends StatelessWidget {
  final List<ChartDataPoint> axes;

  const RadarComparisonChart({super.key, required this.axes});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Market Comparison',
            style: TextStyle(color: colors.foreground, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        if (axes.isEmpty)
          Text('Not enough data to compare this listing yet.',
              style: TextStyle(color: colors.mutedForeground, fontSize: 12))
        else
          Semantics(
            label: 'Radar chart comparing ${axes.map((a) => '${a.label} ${a.value.round()} of 100').join(', ')}',
            child: SizedBox(
              height: 220,
              // Issue #110 "Raster Cache Optimization": the polygon only
              // changes when [axes] does (see RadarChartPainter.shouldRepaint),
              // so isolate it in its own raster layer to skip GPU redraw on
              // ancestor rebuilds (e.g. scrolling the surrounding screen).
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: RadarChartPainter(
                    axes: axes,
                    gridColor: colors.border,
                    fillColor: colors.primary,
                    strokeColor: colors.primary,
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 8),
        Text('*Compared to the neighborhood average for this category.',
            style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
      ]),
    );
  }
}
