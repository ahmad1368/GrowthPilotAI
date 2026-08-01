import 'package:growth_pilot_ai/core/models/daily_traffic_analytics.dart';

/// Finds the weekday with the highest average total (foot + vehicle)
/// traffic across all logged days (Issue #381), used to surface the
/// optimal window for window displays and outdoor marketing.
class FindPeakTrafficWeekday {
  static String? call(List<DailyTrafficAnalytics> results) {
    if (results.isEmpty) return null;

    final totalsByWeekday = <String, List<int>>{};
    for (final r in results) {
      totalsByWeekday.putIfAbsent(r.weekdayLabel, () => []).add(r.totalTraffic);
    }

    var bestWeekday = totalsByWeekday.keys.first;
    var bestAverage = -1.0;
    for (final entry in totalsByWeekday.entries) {
      final average = entry.value.reduce((a, b) => a + b) / entry.value.length;
      if (average > bestAverage) {
        bestAverage = average;
        bestWeekday = entry.key;
      }
    }
    return bestWeekday;
  }
}
