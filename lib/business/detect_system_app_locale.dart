import 'dart:ui';
import 'package:growth_pilot_ai/business/resolve_app_locale_from_code.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

/// "System Detection: the app/site correctly identifies en-CA, fr-CA,
/// and fa-IR and loads the appropriate locale" (Issue #179 AC) —
/// matches the device's platform locale's base language code (e.g.
/// "fr" out of "fr-CA") against this app's supported [AppLocale]s via
/// [ResolveAppLocaleFromCode], falling back to English exactly the
/// same way. Only *suggests* a match on the existing first-launch
/// picker (Issue #429's `LanguageSetupScreen`) instead of silently
/// bypassing its deliberate "always ask once" UX (see PR notes).
class DetectSystemAppLocale {
  static AppLocale call([Locale? platformLocale]) {
    final locale = platformLocale ?? PlatformDispatcher.instance.locale;
    return ResolveAppLocaleFromCode.call(locale.languageCode);
  }
}
