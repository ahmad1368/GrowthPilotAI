import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/profile_controller.dart';
import 'package:growth_pilot_ai/validators/profile_name_validator.dart';

/// [Issue #826] Display-name field, shown in-app and to other users.
class ProfileNameField extends StatelessWidget {
  final ProfileController controller;
  const ProfileNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Not wrapped in Obx: this field is the only writer of displayName, so
    // reacting to its own writes would just reset the cursor every keystroke.
    return TextFormField(
      initialValue: controller.displayName.value,
      decoration: InputDecoration(
        labelText: 'profile_name_label'.tr,
        border: const OutlineInputBorder(),
      ),
      validator: ProfileNameValidator.call,
      onChanged: (value) => controller.displayName.value = value,
    );
  }
}
