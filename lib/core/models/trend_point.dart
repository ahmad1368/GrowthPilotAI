import 'package:flutter/foundation.dart';

/// One `{ date, value }` point from [GetPriceTrend] (Issue #102 AC:
/// "API output ... compatible with Recharts") — the Flutter analog of
/// that array shape, ready for whichever chart widget consumes it.
@immutable
class TrendPoint {
  final DateTime date;
  final double value;

  const TrendPoint({required this.date, required this.value});
}
