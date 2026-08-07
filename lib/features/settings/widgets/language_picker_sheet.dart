import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/locale_controller.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/language_option_tile.dart';

/// Bottom sheet for changing the app language at runtime (Issue #429,
/// acceptance criterion 1) — reuses [LanguageOptionTile] from the
/// first-launch wizard.
Future<void> showLanguagePickerSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final locale in AppLocale.values)
              LanguageOptionTile(
                locale: locale,
                onTap: () async {
                  await Get.find<LocaleController>().changeLocale(locale);
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    ),
  );
}
