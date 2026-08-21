import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/branding_settings_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/branding_color_swatch_row.dart';
import 'package:growth_pilot_ai/features/settings/widgets/branding_company_name_field.dart';
import 'package:growth_pilot_ai/features/settings/widgets/branding_logo_picker.dart';

/// "Branding Configuration" screen (Issue #257) — company logo, name,
/// and brand color, applied to the traceability PDF header on save;
/// no server/S3 round-trip exists locally (see PR notes).
class BrandingSettingsScreen extends StatelessWidget {
  const BrandingSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final controller = Get.find<BrandingSettingsController>();
    final labelStyle = TextStyle(color: colors.foreground, fontWeight: FontWeight.bold);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Branding'), backgroundColor: colors.background),
      body: Obx(() => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Company logo', style: labelStyle),
              const SizedBox(height: 8),
              BrandingLogoPicker(logoBytes: controller.logoBytes.value, onChanged: controller.setLogo),
              const SizedBox(height: 24),
              Text('Company name', style: labelStyle),
              const SizedBox(height: 8),
              BrandingCompanyNameField(
                initialValue: controller.companyName.value,
                onChanged: (v) => controller.companyName.value = v,
              ),
              const SizedBox(height: 24),
              Text('Brand color', style: labelStyle),
              const SizedBox(height: 8),
              BrandingColorSwatchRow(
                selectedHex: controller.brandColorHex.value,
                onSelected: controller.setBrandColor,
              ),
              const SizedBox(height: 32),
              ShadButton(onPressed: controller.save, child: const Text('Save branding')),
            ],
          )),
    );
  }
}
