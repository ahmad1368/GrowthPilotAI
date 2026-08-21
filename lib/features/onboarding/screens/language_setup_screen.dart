import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/detect_system_app_locale.dart';
import 'package:growth_pilot_ai/controllers/locale_controller.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/language_option_tile.dart';

/// First-launch language picker (Issue #429, acceptance criterion 2)
/// — shown once before the real app content by [AppLocaleGate]. The
/// device's system locale (Issue #179 AC: "System Detection") is
/// highlighted as a suggestion via [DetectSystemAppLocale], not
/// auto-applied — the user still picks explicitly.
class LanguageSetupScreen extends StatelessWidget {
  final VoidCallback onDone;
  const LanguageSetupScreen({super.key, required this.onDone});

  Future<void> _select(AppLocale locale) async {
    await Get.find<LocaleController>().changeLocale(locale);
    onDone();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final suggested = DetectSystemAppLocale.call();
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('onboarding_welcome_title'.tr, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('onboarding_welcome_subtitle'.tr,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.7))),
              const SizedBox(height: 24),
              for (final locale in AppLocale.values)
                LanguageOptionTile(
                  locale: locale,
                  isSuggested: locale == suggested,
                  onTap: () => _select(locale),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
