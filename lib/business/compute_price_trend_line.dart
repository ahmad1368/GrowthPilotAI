import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

/// "Price Trend Lines" (Issue #148) — daily average requested-budget
/// midpoint over a rolling window (e.g. 30/60/90 days).
class ComputePriceTrendLine {
  static List<({DateTime day, double avgBudget})> call(
      List<ProcurementRequestEntity> requests, int windowDays, DateTime now) {
    final cutoff = now.subtract(Duration(days: windowDays));
    final byDay = <DateTime, List<double>>{};
    for (final r in requests) {
      if (!r.createdAt.isAfter(cutoff)) continue;
      final day = DateTime(r.createdAt.year, r.createdAt.month, r.createdAt.day);
      byDay.putIfAbsent(day, () => []).add((r.budgetMin + r.budgetMax) / 2);
    }
    final result = byDay.entries
        .map((e) => (day: e.key, avgBudget: e.value.reduce((a, b) => a + b) / e.value.length))
        .toList()
      ..sort((a, b) => a.day.compareTo(b.day));
    return result;
  }
}
