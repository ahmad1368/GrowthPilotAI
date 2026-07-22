import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/order_specs_by_layout.dart';
import 'package:growth_pilot_ai/controllers/business_compass_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/core/widgets/dynamic_report_grid.dart';
import 'package:growth_pilot_ai/core/widgets/reorderable_report_list.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compass_controls_row.dart';

/// Business Compass body (Issues #84/#111/#113/#114): view mode renders the
/// masonry [DynamicReportGrid] in the user's saved order; reorder mode swaps
/// in [ReorderableReportList] for long-press drag editing.
class BusinessCompassBody extends StatelessWidget {
  final bool reordering;

  const BusinessCompassBody({super.key, required this.reordering});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BusinessCompassController>();
    final layoutController = Get.find<WidgetLayoutController>();

    return Obx(() {
      final specsById = {for (final s in controller.reportSpecs) s.id: s};
      final ordered =
          OrderSpecsByLayout.call(controller.reportSpecs, layoutController.layout);

      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CompassControlsRow(controller: controller),
          const SizedBox(height: 16),
          reordering
              ? ReorderableReportList(
                  layout: layoutController.layout,
                  specsById: specsById,
                  onReorder: layoutController.reorder,
                )
              : DynamicReportGrid(specs: ordered),
        ],
      );
    });
  }
}
