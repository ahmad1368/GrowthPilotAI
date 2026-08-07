/// Resolves one translation key against a primary bundle, falling
/// back to a secondary bundle, then to the raw key itself (Issue
/// #429, acceptance criterion 5) — so a lazily-loaded locale missing
/// a newer key never shows a blank string.
class TranslateWithFallback {
  static String call(String key, Map<String, String> primary, Map<String, String> fallback) {
    return primary[key] ?? fallback[key] ?? key;
  }
}
