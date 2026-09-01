import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/seasonal_demand_point.dart';
import 'package:growth_pilot_ai/core/utils/analytics_utils.dart';

/// Averages income by calendar month across every year of local transaction
/// history (Issue #352), so a recurring seasonal spike surfaces even with
/// only a couple of years of data. No weather/holiday-calendar correlation
/// or ML retraining pipeline — see [SeasonalDemandReportWidget] for why.
class ComputeSeasonalDemand {
  static List<SeasonalDemandPoint> call(List<TransactionEntity> transactions) {
    // Group by (month, year) first so multiple Januaries average together
    // instead of summing into one inflated bucket.
    final byMonthThenYear = <int, Map<int, double>>{};
    for (final tx in transactions) {
      if (tx.type != TransactionType.income) continue;
      final years = byMonthThenYear.putIfAbsent(tx.date.month, () => {});
      years[tx.date.year] = (years[tx.date.year] ?? 0) + tx.amount;
    }

    final points = [
      for (var month = 1; month <= 12; month++)
        SeasonalDemandPoint(
          month: month,
          averageRevenue: AnalyticsUtils.calculateAverage(
              byMonthThenYear[month]?.values.toList() ?? const []),
        ),
    ];

    final peak = points.reduce(
        (a, b) => b.averageRevenue > a.averageRevenue ? b : a);
    if (peak.averageRevenue <= 0) return points;

    return [
      for (final p in points)
        p.month == peak.month
            ? SeasonalDemandPoint(
                month: p.month, averageRevenue: p.averageRevenue, isPeak: true)
            : p,
    ];
  }
}
