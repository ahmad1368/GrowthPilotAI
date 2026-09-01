import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/locale_controller.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/settings/widgets/language_picker_sheet.dart';

/// Runtime language switcher for the Settings screen (Issue #429,
/// acceptance criterion 1) — the same [LocaleController] the
/// first-launch wizard uses, so choosing a language here updates the
/// whole app instantly with no restart.
class LanguageSettingsSection extends StatelessWidget {
  const LanguageSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocaleController>();
    final theme = Theme.of(context);
    return Obx(() => ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(Icons.language_rounded, color: theme.colorScheme.onSurface),
          title: Text('settings_language_title'.tr),
          subtitle: Text(controller.current.value.nativeName, style: const TextStyle(fontSize: 12)),
          trailing: Icon(Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
          onTap: () => showLanguagePickerSheet(context),
        ));
  }
}
