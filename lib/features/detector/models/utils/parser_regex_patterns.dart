class ParserRegexPatterns {
  static final List<RegExp> datePatterns = [
    RegExp(r'\d{4}[-/]\d{2}[-/]\d{2}'), // YYYY-MM-DD
    RegExp(r'\d{2}[-/]\d{2}[-/]\d{4}'), // MM-DD-YYYY
    RegExp(r'\d{2}[-/]\d{2}[-/]\d{2}'), // MM-DD-YY
    RegExp(
        r'(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{2},?\s+\d{4}',
        caseSensitive: false),
  ];

  static final RegExp usdPattern =
      RegExp(r'(USD|US\$|\$US)', caseSensitive: false);
  static final RegExp cadPattern =
      RegExp(r'(HST|GST|PST|CDN|CAD|\bTotal\s+CAD\b)', caseSensitive: false);
}
