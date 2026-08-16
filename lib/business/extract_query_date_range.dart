/// Extracts an absolute date range from relative time phrases in a
/// query (Issue #199's "Query Pre-processing... convert relative terms
/// like 'Last month' into absolute dates based on the current system
/// time"). Returns null when no recognized timeframe is mentioned.
class ExtractQueryDateRange {
  static const _months = [
    'january', 'february', 'march', 'april', 'may', 'june',
    'july', 'august', 'september', 'october', 'november', 'december',
  ];

  static (DateTime, DateTime)? call(String query, DateTime now) {
    final text = query.toLowerCase();

    final lastNDays = RegExp(r'last (\d+) days?').firstMatch(text);
    if (lastNDays != null) {
      return (now.subtract(Duration(days: int.parse(lastNDays.group(1)!))), now);
    }

    if (text.contains('this month')) return (DateTime(now.year, now.month, 1), now);
    if (text.contains('last month')) {
      return (
        DateTime(now.year, now.month - 1, 1),
        DateTime(now.year, now.month, 1).subtract(const Duration(seconds: 1)),
      );
    }

    final quarterStartMonth = ((now.month - 1) ~/ 3) * 3 + 1;
    if (text.contains('this quarter')) return (DateTime(now.year, quarterStartMonth, 1), now);
    if (text.contains('last quarter')) {
      return (
        DateTime(now.year, quarterStartMonth - 3, 1),
        DateTime(now.year, quarterStartMonth, 1).subtract(const Duration(seconds: 1)),
      );
    }

    for (var i = 0; i < _months.length; i++) {
      if (!text.contains(_months[i])) continue;
      final monthNum = i + 1;
      final year = monthNum > now.month ? now.year - 1 : now.year;
      return (DateTime(year, monthNum, 1), DateTime(year, monthNum + 1, 1).subtract(const Duration(seconds: 1)));
    }

    return null;
  }
}
