import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

/// Pure, on-device time-series preparation for the analytics/forecasting
/// engine. Transforms scattered transactions into a continuous, zero-padded
/// daily spending sequence. Only numeric amounts and dates are used — no
/// vendor/description PII ever enters the resulting series.
class TimeSeriesService {
  /// Groups transactions into daily totals keyed by date-only (midnight).
  static Map<DateTime, double> aggregateByDay(
    List<TransactionEntity> transactions,
  ) {
    final Map<DateTime, double> totals = {};
    for (final tx in transactions) {
      final key = DateTime(tx.date.year, tx.date.month, tx.date.day);
      totals[key] = (totals[key] ?? 0.0) + tx.amount;
    }
    return totals;
  }

  /// Builds a continuous, chronological daily series of length
  /// [daysBack] + 1, inserting 0.0 for days without transactions so the
  /// output is a gap-free sequence (index 0 = oldest day, last = [endDate]).
  static List<double> prepareDailySeries(
    List<TransactionEntity> transactions,
    int daysBack, {
    DateTime? endDate,
  }) {
    final end = endDate ?? DateTime.now();
    final totals = aggregateByDay(transactions);
    final startDay = end.day - daysBack;

    return List<double>.generate(daysBack + 1, (i) {
      // Component-based construction normalizes overflow and sidesteps
      // DST hour-shifts that Duration arithmetic can introduce.
      final day = DateTime(end.year, end.month, startDay + i);
      return totals[day] ?? 0.0;
    });
  }
}
