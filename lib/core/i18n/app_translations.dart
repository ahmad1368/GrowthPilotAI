import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/i18n/translations/en_translations.dart';

/// GetX translation source (Issue #429) — starts with only English
/// eagerly loaded; [LocaleBundleLoader] adds other locales' keys via
/// `Get.addTranslations` the first time each is selected, and GetX
/// falls back to [fallbackLocale] (English) for any key a lazily
/// loaded bundle doesn't define yet.
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en': enTranslations};
}
