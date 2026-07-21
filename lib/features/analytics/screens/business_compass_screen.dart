import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/business_compass_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_radar_chart.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compass_metric_legend.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compass_period_chips.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compass_sector_chips.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Business Compass screen (Issue #84): the user's "Success DNA" radar vs.
/// a mocked sector benchmark (Issue #83). Flat shadcn_ui per the current
/// design system, not the original issue's Glassmorphism ask.
class BusinessCompassScreen extends StatelessWidget {
  const BusinessCompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final controller = Get.find<BusinessCompassController>();

    return ShadTheme(
      data: AppShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('Business Compass')),
        body: Obx(() => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CompassSectorChips(
                  selected: controller.selectedSector.value,
                  onChanged: controller.changeSector,
                ),
                const SizedBox(height: 12),
                CompassPeriodChips(
                  selected: controller.selectedPeriod.value,
                  onChanged: controller.changePeriod,
                ),
                const SizedBox(height: 16),
                BusinessRadarChart(
                  userMetrics: controller.userMetrics.value,
                  sectorMetrics: controller.sectorMetrics,
                ),
                const SizedBox(height: 8),
                Text(
                    'Last updated: ${controller.lastUpdatedAt.toString().split('.').first}',
                    style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 8),
                CompassMetricLegend(userMetrics: controller.userMetrics.value),
              ],
            )),
      ),
    );
  }
}
