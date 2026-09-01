import 'package:growth_pilot_ai/business/canadian_statutory_holidays.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/holiday_sales_impact.dart';

/// Compares revenue in a +/-1-day window around each statutory holiday
/// against an ordinary-day baseline (Issue #388) — a historical-average
/// heuristic, not the issue's literal ML-predicted "post-event actual vs.
/// predicted" model, which this app has no data or backend for.
class ComputeHolidaySalesImpact {
  static const _windowDays = 1;

  static List<HolidaySalesImpact> call(List<TransactionEntity> transactions) {
    final income = transactions.where((t) => t.type == TransactionType.income).toList();
    if (income.isEmpty) return [];

    final years = income.map((t) => t.date.year).toSet();
    final totalIncome = income.fold(0.0, (sum, t) => sum + t.amount);
    final firstDate = income.map((t) => t.date).reduce((a, b) => a.isBefore(b) ? a : b);
    final lastDate = income.map((t) => t.date).reduce((a, b) => a.isAfter(b) ? a : b);
    final totalDays = lastDate.difference(firstDate).inDays + 1;
    final dailyAvg = totalIncome / totalDays;
    final baselineWindowRevenue = dailyAvg * (_windowDays * 2 + 1);

    final results = <HolidaySalesImpact>[];
    for (final holiday in canadianStatutoryHolidays) {
      double windowRevenue = 0;
      var occurrences = 0;
      for (final year in years) {
        final holidayDate = DateTime(year, holiday.month, holiday.day);
        final start = holidayDate.subtract(const Duration(days: _windowDays));
        final end = holidayDate.add(const Duration(days: _windowDays));
        final matched =
            income.where((t) => !t.date.isBefore(start) && !t.date.isAfter(end));
        if (matched.isNotEmpty) {
          windowRevenue += matched.fold(0.0, (sum, t) => sum + t.amount);
          occurrences++;
        }
      }
      if (occurrences == 0) continue;
      results.add(HolidaySalesImpact(
        holidayName: holiday.name,
        holidayRevenue: windowRevenue / occurrences,
        baselineRevenue: baselineWindowRevenue,
      ));
    }

    results.sort((a, b) => b.liftPercent.compareTo(a.liftPercent));
    return results;
  }
}
