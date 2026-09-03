class ParserRegexPatterns {
  // ISO/Big-Endian: 2026-04-02 or 2026/04/02.
  static final RegExp isoDate = RegExp(r'(\d{4})[-/](\d{2})[-/](\d{2})');

  // North American with a 4-digit year: 04/02/2026.
  static final RegExp northAmericanDate =
      RegExp(r'(\d{2})[-/](\d{2})[-/](\d{4})');

  // Short form with a 2-digit year: 04/02/26.
  static final RegExp shortYearDate =
      RegExp(r'(\d{2})[-/](\d{2})[-/](\d{2})(?!\d)');

  // Month-name dates, e.g. "Apr 02, 2026" or "Apr 02". The year group is
  // optional — DateUtilityParser defaults to the current year when it's
  // absent (Issue #24 AC: missing-year normalization).
  static final RegExp monthNamePattern = RegExp(
      r'(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+(\d{1,2}),?\s*(\d{4})?',
      caseSensitive: false);

  static final RegExp usdPattern =
      RegExp(r'(USD|US\$|\$US)', caseSensitive: false);
  static final RegExp cadPattern =
      RegExp(r'(HST|GST|PST|CDN|CAD|\bTotal\s+CAD\b)', caseSensitive: false);
}
