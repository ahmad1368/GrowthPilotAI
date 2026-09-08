import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/profile_controller.dart';
import 'package:growth_pilot_ai/core/data/canadian_business_categories.dart';
import 'package:growth_pilot_ai/core/models/business_category.dart';
import 'package:growth_pilot_ai/features/profile/widgets/profile_business_subcategory_field.dart';

/// [Issue #826] Two-level parent-category / child-subcategory dropdown
/// pair for the profile's business type.
class ProfileBusinessCategoryField extends StatelessWidget {
  final ProfileController controller;
  const ProfileBusinessCategoryField({super.key, required this.controller});

  BusinessCategory? _findCategory(String id) {
    for (final c in canadianBusinessCategories) {
      if (c.id == id) return c;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categoryId = controller.businessCategoryId.value;
      final category = _findCategory(categoryId);
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DropdownButtonFormField<String>(
          value: categoryId.isEmpty ? null : categoryId,
          decoration: InputDecoration(
            labelText: 'profile_business_category_label'.tr,
            border: const OutlineInputBorder(),
          ),
          items: canadianBusinessCategories
              .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
              .toList(),
          onChanged: (value) => controller.selectCategory(value ?? ''),
        ),
        if (category != null && category.children.isNotEmpty) ...[
          const SizedBox(height: 12),
          ProfileBusinessSubcategoryField(controller: controller, category: category),
        ],
      ]);
    });
  }
}
