import 'package:growth_pilot_ai/business/extract_query_date_range.dart';
import 'package:growth_pilot_ai/core/models/query_intent.dart';

/// Combines timeframe/category/location extraction into one intent
/// (Issue #199's "Hybrid Intent Analysis") — a lightweight keyword
/// match, not a full NER model, per the issue's own "Regex or NER"
/// either/or framing.
class ParseQueryIntent {
  static const _categories = ['fuel', 'rent', 'office supplies', 'payroll', 'utilities'];
  static const _locations = ['surrey', 'burnaby', 'vancouver', 'coquitlam', 'north vancouver'];

  static QueryIntent call(String query, DateTime now) {
    final text = query.toLowerCase();
    final range = ExtractQueryDateRange.call(query, now);

    return QueryIntent(
      rangeStart: range?.$1,
      rangeEnd: range?.$2,
      category: _firstMatch(text, _categories),
      location: _firstMatch(text, _locations),
    );
  }

  static String? _firstMatch(String text, List<String> options) {
    for (final option in options) {
      if (text.contains(option)) return option;
    }
    return null;
  }
}
