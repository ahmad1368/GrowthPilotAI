import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';

/// Builds the [RadarChartData] for [BusinessRadarChart] (Issue #84), split
/// out to keep that widget under the file-size budget.
class RadarChartDataBuilder {
  static RadarChartData build({
    required BusinessCompassMetrics userMetrics,
    required BusinessCompassMetrics sectorMetrics,
    required bool showSectorOverlay,
    required Color primary,
  }) {
    return RadarChartData(
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
    );
  }
}
