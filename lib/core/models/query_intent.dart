import 'package:flutter/foundation.dart';

/// Extracted meaning of a user's natural-language query (Issue #199's
/// "Hybrid Intent Analysis") — any field left null means that facet
/// wasn't mentioned, so the caller falls back to an unfiltered search.
@immutable
class QueryIntent {
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final String? category;
  final String? location;

  const QueryIntent({this.rangeStart, this.rangeEnd, this.category, this.location});
}
