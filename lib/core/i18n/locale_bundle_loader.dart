import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/core/i18n/deferred_locale_loaders.dart';
import 'package:growth_pilot_ai/core/i18n/translations/en_translations.dart';

/// Lazily loads one locale's translation bundle (Issue #429, acceptance
/// criterion 5) — only English ships in the initial payload; every
/// other language is fetched as a separate deferred library chunk
/// (see `deferred_locale_loaders.dart`) the first time it's selected.
class LocaleBundleLoader {
  static final _cache = <AppLocale, Map<String, String>>{AppLocale.en: enTranslations};

  static Future<Map<String, String>> load(AppLocale locale) async {
    final cached = _cache[locale];
    if (cached != null) return cached;

    final bundle = switch (locale) {
      AppLocale.en => enTranslations,
      AppLocale.fr => await loadFrBundle(),
      AppLocale.zhHans => await loadZhBundle(),
      AppLocale.pa => await loadPaBundle(),
      AppLocale.es => await loadEsBundle(),
      AppLocale.fa => await loadFaBundle(),
      AppLocale.ar => await loadArBundle(),
    };
    _cache[locale] = bundle;
    return bundle;
  }
}
