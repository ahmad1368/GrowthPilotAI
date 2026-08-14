import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/seasonal_overhead_point.dart';
import 'package:growth_pilot_ai/core/utils/analytics_utils.dart';

/// Averages expense by calendar month across every year of local
/// transaction history (Issue #386), mirroring [ComputeSeasonalDemand]'s
/// income version. No weather/HVAC-sensor correlation — see
/// [SeasonalOverheadReportWidget] for why.
class ComputeSeasonalOverhead {
  static List<SeasonalOverheadPoint> call(List<TransactionEntity> transactions) {
    final byMonthThenYear = <int, Map<int, double>>{};
    for (final tx in transactions) {
      if (tx.type != TransactionType.expense) continue;
      final years = byMonthThenYear.putIfAbsent(tx.date.month, () => {});
      years[tx.date.year] = (years[tx.date.year] ?? 0) + tx.amount;
    }

    final points = [
      for (var month = 1; month <= 12; month++)
        SeasonalOverheadPoint(
          month: month,
          averageExpense: AnalyticsUtils.calculateAverage(
              byMonthThenYear[month]?.values.toList() ?? const []),
        ),
    ];

    final peak =
        points.reduce((a, b) => b.averageExpense > a.averageExpense ? b : a);
    if (peak.averageExpense <= 0) return points;

    return [
      for (final p in points)
        p.month == peak.month
            ? SeasonalOverheadPoint(
                month: p.month, averageExpense: p.averageExpense, isPeak: true)
            : p,
    ];
  }
}
