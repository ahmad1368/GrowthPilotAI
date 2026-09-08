import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/profile_controller.dart';

/// [Issue #826] Tappable field opening a date picker for the profile's
/// birth date.
class ProfileBirthdateField extends StatelessWidget {
  final ProfileController controller;
  const ProfileBirthdateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final date = controller.birthDate.value;
      return InkWell(
        onTap: () => _pickDate(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'profile_birthdate_label'.tr,
            border: const OutlineInputBorder(),
          ),
          child: Text(date != null
              ? '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
              : '—'),
        ),
      );
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: controller.birthDate.value ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) controller.birthDate.value = picked;
  }
}
