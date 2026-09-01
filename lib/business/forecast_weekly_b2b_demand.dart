import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';

/// "Time-Series Forecasting" (Issue #129) — buckets requests into
/// weekly counts since the earliest broadcast and extrapolates next
/// week's demand via the existing [ForecastEngine] least-squares model.
class ForecastWeeklyB2BDemand {
  static double call(List<ProcurementRequestEntity> requests) {
    if (requests.isEmpty) return 0.0;
    final sorted = [...requests]..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final anchor = sorted.first.createdAt;

    final weekCounts = <int, int>{};
    for (final r in sorted) {
      final week = r.createdAt.difference(anchor).inDays ~/ 7;
      weekCounts[week] = (weekCounts[week] ?? 0) + 1;
    }
    final maxWeek = weekCounts.keys.reduce((a, b) => a > b ? a : b);
    final series = List<double>.generate(maxWeek + 1, (i) => (weekCounts[i] ?? 0).toDouble());

    return ForecastEngine.predictNext(series, 1).first;
  }
}
