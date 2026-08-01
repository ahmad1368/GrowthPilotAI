import 'package:growth_pilot_ai/business/find_peak_traffic_weekday.dart';
import 'package:growth_pilot_ai/core/models/daily_traffic_analytics.dart';

/// One-sentence read naming the peak footfall weekday and best logged
/// conversion day (Issue #381).
class BuildFootTrafficNarrative {
  static String call(List<DailyTrafficAnalytics> results) {
    if (results.isEmpty) {
      return 'No traffic counts logged yet — add one to start tracking footfall.';
    }
    final peakWeekday = FindPeakTrafficWeekday.call(results);
    final best = results.first;
    if (results.length == 1) {
      return 'Conversion was ${best.conversionPercent.toStringAsFixed(1)}% '
          'on that logged $peakWeekday.';
    }
    return '$peakWeekday sees the most traffic on average — best conversion '
        'hit ${best.conversionPercent.toStringAsFixed(1)}%.';
  }
}
