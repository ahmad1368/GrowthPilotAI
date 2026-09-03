import '../utils/month_name_resolver.dart';
import '../utils/parser_regex_patterns.dart';

/// Normalizes OCR'd receipt text into a [DateTime] (Issue #24). Dates are
/// built directly from regex capture groups rather than reassembled into a
/// string for [DateTime.tryParse] — that method requires a 4-6 digit
/// leading year, so a naive "MM-DD-YYYY" string swap silently fails
/// (`DateTime.tryParse("04-02-2026")` returns null). Month-name dates
/// ("Apr 02, 2026") can't go through [DateTime.tryParse] at all, so they're
/// resolved via [MonthNameResolver] instead, defaulting to the current year
/// when the receipt omits it.
class DateUtilityParser {
  static DateTime? findAndNormalizeDate(List<String> lines) {
    for (var line in lines) {
      final date = _matchNumeric(line) ?? _matchMonthName(line);
      if (date != null) return date;
    }
    return null;
  }

  static DateTime? _matchNumeric(String line) {
    final iso = ParserRegexPatterns.isoDate.firstMatch(line);
    if (iso != null) {
      return DateTime(int.parse(iso.group(1)!), int.parse(iso.group(2)!),
          int.parse(iso.group(3)!));
    }

    final na = ParserRegexPatterns.northAmericanDate.firstMatch(line);
    if (na != null) {
      return DateTime(int.parse(na.group(3)!), int.parse(na.group(1)!),
          int.parse(na.group(2)!));
    }

    final shortYear = ParserRegexPatterns.shortYearDate.firstMatch(line);
    if (shortYear != null) {
      return DateTime(2000 + int.parse(shortYear.group(3)!),
          int.parse(shortYear.group(1)!), int.parse(shortYear.group(2)!));
    }
    return null;
  }

  static DateTime? _matchMonthName(String line) {
    final match = ParserRegexPatterns.monthNamePattern.firstMatch(line);
    if (match == null) return null;

    final month = MonthNameResolver.indexOf(match.group(1)!);
    final day = int.tryParse(match.group(2)!);
    if (month == null || day == null) return null;

    final yearGroup = match.group(3);
    final year =
        yearGroup != null ? int.parse(yearGroup) : DateTime.now().year;

    return DateTime(year, month, day);
  }
}
