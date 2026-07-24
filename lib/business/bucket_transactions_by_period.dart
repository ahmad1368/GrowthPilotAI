import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';

/// Groups transactions into period-start-keyed buckets (Issue #350): daily
/// = midnight of each day, weekly = the Monday of that ISO week, monthly =
/// the 1st of that month.
class BucketTransactionsByPeriod {
  static Map<DateTime, List<TransactionEntity>> call(
    List<TransactionEntity> transactions,
    MarginPeriod period,
  ) {
    final buckets = <DateTime, List<TransactionEntity>>{};
    for (final tx in transactions) {
      final key = _keyFor(tx.date, period);
      (buckets[key] ??= []).add(tx);
    }
    return buckets;
  }

  static DateTime _keyFor(DateTime date, MarginPeriod period) {
    switch (period) {
      case MarginPeriod.daily:
        return DateTime(date.year, date.month, date.day);
      case MarginPeriod.weekly:
        final monday = date.subtract(Duration(days: date.weekday - 1));
        return DateTime(monday.year, monday.month, monday.day);
      case MarginPeriod.monthly:
        return DateTime(date.year, date.month, 1);
    }
  }
}
