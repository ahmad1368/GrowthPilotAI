/// Resolves 3-letter month abbreviations (e.g. "Apr") captured by
/// [ParserRegexPatterns.monthNamePattern] into their calendar index.
/// `DateTime.tryParse` has no notion of month names, so this fills the gap
/// (Issue #24) — without it, a receipt date like "Apr 02, 2026" silently
/// fails to parse and falls back to today's date.
class MonthNameResolver {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static int? indexOf(String abbreviation) {
    final index = _months.indexWhere(
      (m) => m.toLowerCase() == abbreviation.toLowerCase(),
    );
    return index == -1 ? null : index + 1;
  }
}
