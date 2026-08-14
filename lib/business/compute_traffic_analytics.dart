import 'package:growth_pilot_ai/core/data/entities/traffic_count_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/daily_traffic_analytics.dart';

const _weekdayNames = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

/// Matches each logged daily foot/vehicular traffic count against
/// same-day transactions to derive a conversion% read (Issue #381) —
/// this app has no municipal sensor/urban movement telemetry feed, so
/// traffic counts are logged manually and correlated with existing
/// transaction data instead, mirroring [ComputeConversionRates].
class ComputeTrafficAnalytics {
  static List<DailyTrafficAnalytics> call(
    List<TrafficCountEntity> counts,
    List<TransactionEntity> transactions,
  ) {
    final results = counts.map((count) {
      final salesCount =
          transactions.where((t) => _isSameDay(t.date, count.date)).length;
      final conversionPercent = count.footTraffic == 0
          ? 0.0
          : (salesCount / count.footTraffic) * 100;

      return DailyTrafficAnalytics(
        date: count.date,
        footTraffic: count.footTraffic,
        vehicleTraffic: count.vehicleTraffic,
        salesCount: salesCount,
        conversionPercent: conversionPercent,
        weekdayLabel: _weekdayNames[count.date.weekday - 1],
      );
    }).toList();

    results.sort((a, b) => b.conversionPercent.compareTo(a.conversionPercent));
    return results;
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
