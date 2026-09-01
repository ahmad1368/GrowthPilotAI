import 'package:growth_pilot_ai/core/enum/app_locale.dart';

/// Maps a persisted/device language code back to an [AppLocale]
/// (Issue #429, acceptance criterion 2) — falls back to English for
/// null, unknown, or unsupported codes rather than crashing.
class ResolveAppLocaleFromCode {
  static AppLocale call(String? code) {
    for (final locale in AppLocale.values) {
      if (locale.languageCode == code) return locale;
    }
    return AppLocale.en;
  }
}
