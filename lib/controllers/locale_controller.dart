import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_dart_locale.dart';
import 'package:growth_pilot_ai/business/resolve_app_locale_from_code.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/core/i18n/locale_bundle_loader.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Owns the active app locale (Issue #429, acceptance criteria 1-2) —
/// persists the choice via [SecureStorageService] and lazily loads
/// each locale's translation bundle before switching (criterion 5),
/// so GetX only ever activates a locale whose strings are ready.
class LocaleController extends GetxController {
  static const _storageKey = 'app_locale_code';
  final Rx<AppLocale> current = AppLocale.en.obs;
  bool hasStoredPreference = false;
  bool restored = false;

  Future<void> restore() async {
    final code = await SecureStorageService.readData(_storageKey);
    hasStoredPreference = code != null;
    if (code != null) await changeLocale(ResolveAppLocaleFromCode.call(code));
    restored = true;
  }

  Future<void> changeLocale(AppLocale locale) async {
    final bundle = await LocaleBundleLoader.load(locale);
    Get.addTranslations({locale.languageCode: bundle});
    Get.updateLocale(BuildDartLocale.call(locale));
    current.value = locale;
    hasStoredPreference = true;
    await SecureStorageService.writeData(_storageKey, locale.languageCode);
  }
}
