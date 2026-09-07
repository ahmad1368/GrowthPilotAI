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
        // [Issue #790] A non-scrollControlled showModalBottomSheet caps at
        // ~56% of screen height; 7 stacked language rows can exceed that on
        // smaller phones. shrinkWrap lets the ListView size to its content
        // while still becoming scrollable if it doesn't fit.
        child: ListView(
          shrinkWrap: true,
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
