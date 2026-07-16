import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/category_mapping_controller.dart';
import 'package:growth_pilot_ai/core/theme/mapping_shad_theme.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/mapping_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Category Mapping screen (Issue #58): review, override, and confirm the
/// mapping engine's (Issue #57) suggestions for uncategorized transactions.
class CategoryMappingScreen extends StatelessWidget {
  const CategoryMappingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final controller = Get.find<CategoryMappingController>();

    return ShadTheme(
      data: MappingShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('Category Mapping')),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.groups.isEmpty) {
            return const Center(child: Text('No uncategorized transactions.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.groups.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) => MappingCard(
              group: controller.groups[index],
              controller: controller,
            ),
          );
        }),
      ),
    );
  }
}
