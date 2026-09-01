import 'package:flutter/foundation.dart';

/// One day's summed transaction total (Issue #261's bar-chart data point).
@immutable
class DailyTotalPoint {
  final DateTime day;
  final double total;

  const DailyTotalPoint({required this.day, required this.total});
}
