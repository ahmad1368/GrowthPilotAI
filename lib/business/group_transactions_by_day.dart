import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/daily_total_point.dart';

/// Buckets transactions by calendar day for the chart view (Issue #261),
/// sorted chronologically.
class GroupTransactionsByDay {
  static List<DailyTotalPoint> call(List<TransactionEntity> transactions) {
    final totals = <DateTime, double>{};
    for (final t in transactions) {
      final day = DateTime(t.date.year, t.date.month, t.date.day);
      totals[day] = (totals[day] ?? 0) + t.amount;
    }
    final points = [
      for (final entry in totals.entries) DailyTotalPoint(day: entry.key, total: entry.value)
    ];
    points.sort((a, b) => a.day.compareTo(b.day));
    return points;
  }
}
