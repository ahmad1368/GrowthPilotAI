/// A language this app's localization core supports (Issue #429) — a
/// representative mix of LTR and RTL languages for Vancouver's
/// multicultural merchant base, not literally every world language,
/// since the "core" here is the switching/loading/formatting engine
/// rather than an exhaustive translation set.
enum AppLocale { en, fr, zhHans, pa, es, fa, ar }

extension AppLocaleX on AppLocale {
  String get languageCode => switch (this) {
        AppLocale.en => 'en',
        AppLocale.fr => 'fr',
        AppLocale.zhHans => 'zh',
        AppLocale.pa => 'pa',
        AppLocale.es => 'es',
        AppLocale.fa => 'fa',
        AppLocale.ar => 'ar',
      };

  String get nativeName => switch (this) {
        AppLocale.en => 'English',
        AppLocale.fr => 'Français',
        AppLocale.zhHans => '简体中文',
        AppLocale.pa => 'ਪੰਜਾਬੀ',
        AppLocale.es => 'Español',
        AppLocale.fa => 'فارسی',
        AppLocale.ar => 'العربية',
      };

  bool get isRtl => this == AppLocale.fa || this == AppLocale.ar;
}
