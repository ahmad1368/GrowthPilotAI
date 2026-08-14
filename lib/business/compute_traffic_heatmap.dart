import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/traffic_day_part.dart';
import 'package:growth_pilot_ai/core/models/traffic_heatmap_cell.dart';

/// Builds the day-of-week x day-part traffic grid (Issue #354) from
/// transaction timestamps — the same foot-traffic proxy already used by
/// [ComputeTrafficDistribution] (#365), since this app has no dedicated
/// Wi-Fi/beacon foot-traffic telemetry.
class ComputeTrafficHeatmap {
  static List<TrafficHeatmapCell> call(List<TransactionEntity> transactions) {
    final counts = <int, Map<TrafficDayPart, int>>{};
    for (final t in transactions) {
      final day = t.date.weekday - 1;
      final part = TrafficDayPart.fromHour(t.date.hour);
      final dayCounts = counts.putIfAbsent(day, () => {});
      dayCounts[part] = (dayCounts[part] ?? 0) + 1;
    }

    final cells = [
      for (var day = 0; day < 7; day++)
        for (final part in TrafficDayPart.values)
          TrafficHeatmapCell(
            dayOfWeek: day,
            dayPart: part,
            count: counts[day]?[part] ?? 0,
            intensity: 0,
          ),
    ];

    final maxCount =
        cells.map((c) => c.count).fold(0, (a, b) => a > b ? a : b);
    if (maxCount <= 0) return cells;

    return [
      for (final c in cells)
        TrafficHeatmapCell(
          dayOfWeek: c.dayOfWeek,
          dayPart: c.dayPart,
          count: c.count,
          intensity: c.count / maxCount,
          isPeak: c.count == maxCount,
        ),
    ];
  }
}
