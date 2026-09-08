import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/profile_controller.dart';
import 'package:growth_pilot_ai/core/models/business_category.dart';

/// [Issue #826] Child-subcategory dropdown, populated from the currently
/// selected parent [BusinessCategory]; split out of
/// ProfileBusinessCategoryField to stay under this repo's per-file line cap.
class ProfileBusinessSubcategoryField extends StatelessWidget {
  final ProfileController controller;
  final BusinessCategory category;
  const ProfileBusinessSubcategoryField(
      {super.key, required this.controller, required this.category});

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<String>(
          value: controller.businessSubcategoryId.value.isEmpty
              ? null
              : controller.businessSubcategoryId.value,
          decoration: InputDecoration(
            labelText: 'profile_business_subcategory_label'.tr,
            border: const OutlineInputBorder(),
          ),
          items: category.children
              .map((s) => DropdownMenuItem(value: s.id, child: Text(s.name)))
              .toList(),
          onChanged: (value) => controller.businessSubcategoryId.value = value ?? '',
        ));
  }
}
