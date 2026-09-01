import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/widget_config_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_preview_controller.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_radar_chart.dart';

/// Registers the Business Compass radar (Issue #84) as a pluggable report
/// widget under id `RADAR_CHART` (Issue #111). Reacts live to the
/// `showBenchmark` config toggle from Issue #115's side-panel — through the
/// Issue #116 [WidgetPreviewController] bridge when it's registered, so an
/// unsaved side-panel edit repaints this chart before "Apply" — falling
/// back to [WidgetConfigController] alone, then to the plain default, when
/// one or both aren't bound (e.g. this widget used standalone/in a test).
class RadarReportWidget extends BaseReportWidget {
  const RadarReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final user = data['user'] as BusinessCompassMetrics;
    final sector = data['sector'] as BusinessCompassMetrics;
    if (!Get.isRegistered<WidgetConfigController>()) {
      return BusinessRadarChart(userMetrics: user, sectorMetrics: sector);
    }
    if (Get.isRegistered<WidgetPreviewController>()) {
      final preview = Get.find<WidgetPreviewController>();
      return Obx(() => BusinessRadarChart(
            userMetrics: user,
            sectorMetrics: sector,
            showSectorOverlay:
                preview.valueFor('RADAR_CHART', 'showBenchmark', true),
            isLivePreview: preview.isPreviewing('RADAR_CHART'),
          ));
    }
    final config = Get.find<WidgetConfigController>();
    return Obx(() => BusinessRadarChart(
          userMetrics: user,
          sectorMetrics: sector,
          showSectorOverlay:
              config.valueFor('RADAR_CHART', 'showBenchmark', true),
        ));
  }
}
