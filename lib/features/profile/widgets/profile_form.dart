import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/profile_controller.dart';
import 'package:growth_pilot_ai/features/profile/widgets/profile_name_field.dart';
import 'package:growth_pilot_ai/features/profile/widgets/profile_birthdate_field.dart';
import 'package:growth_pilot_ai/features/profile/widgets/profile_business_category_field.dart';

/// [Issue #826] Assembles the profile's editable fields plus the Save
/// action; split out of ProfileScreen to stay under this repo's
/// per-file line cap.
class ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ProfileController controller;
  final VoidCallback onSaved;

  const ProfileForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: ListView(children: [
          ProfileNameField(controller: controller),
          const SizedBox(height: 16),
          ProfileBirthdateField(controller: controller),
          const SizedBox(height: 16),
          ProfileBusinessCategoryField(controller: controller),
          const SizedBox(height: 24),
          ShadButton(onPressed: _save, child: Text('common_save'.tr)),
        ]),
      ),
    );
  }

  Future<void> _save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    await controller.save();
    onSaved();
  }
}
