import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';

/// The Business Compass radar (Issue #84): the sector benchmark ("Ghost")
/// behind the user's own data ("Live"). Flat fills per the current design
/// system — no glow/blur despite the original issue's literal
/// Glassmorphism ask.
class BusinessRadarChart extends StatelessWidget {
  final BusinessCompassMetrics userMetrics;
  final BusinessCompassMetrics sectorMetrics;

  /// Issue #115's config side-panel toggle: hides the sector "Ghost"
  /// overlay when the user only wants to see their own numbers.
  final bool showSectorOverlay;

  const BusinessRadarChart({
    super.key,
    required this.userMetrics,
    required this.sectorMetrics,
    this.showSectorOverlay = true,
  });

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
          getTitle: (index, angle) => RadarChartTitle(
              text: BusinessCompassMetrics.labels[index], angle: angle),
          titleTextStyle: const TextStyle(fontSize: 11),
          dataSets: [
            if (showSectorOverlay)
              RadarDataSet(
                fillColor: Colors.grey.withValues(alpha: 0.15),
                borderColor: Colors.grey,
                borderWidth: 1.5,
                dataEntries: sectorMetrics
                    .toList()
                    .map((v) => RadarEntry(value: v))
                    .toList(),
              ),
            RadarDataSet(
              fillColor: primary.withValues(alpha: 0.25),
              borderColor: primary,
              borderWidth: 2,
              dataEntries:
                  userMetrics.toList().map((v) => RadarEntry(value: v)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
