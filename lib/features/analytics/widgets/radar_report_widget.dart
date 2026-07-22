import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_radar_chart.dart';

/// Registers the Business Compass radar (Issue #84) as a pluggable report
/// widget under id `RADAR_CHART` (Issue #111).
class RadarReportWidget extends BaseReportWidget {
  const RadarReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return BusinessRadarChart(
      userMetrics: data['user'] as BusinessCompassMetrics,
      sectorMetrics: data['sector'] as BusinessCompassMetrics,
    );
  }
}
