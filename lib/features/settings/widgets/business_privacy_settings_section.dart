import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/business_contact_visibility_controller.dart';
import 'package:growth_pilot_ai/core/enum/contact_field.dart';
import 'package:growth_pilot_ai/features/settings/widgets/privacy_field_toggle_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Granular Privacy Controls" settings section (Issue #218) — four
/// inline toggle rows for the business's public-facing contact fields.
class BusinessPrivacySettingsSection extends StatelessWidget {
  final BusinessContactVisibilityController controller;

  const BusinessPrivacySettingsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      final s = controller.settings.value;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            PrivacyFieldToggleRow(
                label: 'Phone number',
                visibility: s.phone,
                onTap: () => controller.toggle(ContactField.phone)),
            PrivacyFieldToggleRow(
                label: 'Address',
                visibility: s.address,
                onTap: () => controller.toggle(ContactField.address)),
            PrivacyFieldToggleRow(
                label: 'Email',
                visibility: s.email,
                onTap: () => controller.toggle(ContactField.email)),
            PrivacyFieldToggleRow(
                label: 'Map location',
                visibility: s.mapLocation,
                onTap: () => controller.toggle(ContactField.mapLocation)),
          ],
        ),
      );
    });
  }
}
