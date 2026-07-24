import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/dashboard_template_controller.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_template_card.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_template_registry.dart';

/// The "Template Store" horizontal preview gallery (Issue #118): one card
/// per archetype in [DashboardTemplateRegistry], plus a way back to the
/// user's own "Custom" arrangement once a template is applied.
class DashboardTemplateGallery extends StatelessWidget {
  const DashboardTemplateGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardTemplateController>();
    return Obx(() {
      final appliedId = controller.appliedTemplateId.value;
      return SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (final template in DashboardTemplateRegistry.all)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DashboardTemplateCard(
                  template: template,
                  isApplied: template.id == appliedId,
                  onTap: () => controller.apply(template),
                ),
              ),
            if (appliedId != null)
              TextButton(
                onPressed: controller.restoreCustom,
                child: const Text('Restore custom'),
              ),
          ],
        ),
      );
    });
  }
}
