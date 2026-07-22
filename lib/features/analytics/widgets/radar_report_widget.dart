import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/widget_config_controller.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_radar_chart.dart';

/// Registers the Business Compass radar (Issue #84) as a pluggable report
/// widget under id `RADAR_CHART` (Issue #111). Reacts live to the
/// `showBenchmark` config toggle from Issue #115's side-panel when a
/// [WidgetConfigController] is registered; otherwise (e.g. this widget
/// used standalone, or in a test with no full DI bootstrap) it just shows
/// the benchmark by default rather than crashing on a missing binding.
class RadarReportWidget extends BaseReportWidget {
  const RadarReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    if (!Get.isRegistered<WidgetConfigController>()) {
      return BusinessRadarChart(
        userMetrics: data['user'] as BusinessCompassMetrics,
        sectorMetrics: data['sector'] as BusinessCompassMetrics,
      );
    }
    final config = Get.find<WidgetConfigController>();
    return Obx(() => BusinessRadarChart(
          userMetrics: data['user'] as BusinessCompassMetrics,
          sectorMetrics: data['sector'] as BusinessCompassMetrics,
          showSectorOverlay:
              config.valueFor('RADAR_CHART', 'showBenchmark', true),
        ));
  }
}
