import 'package:growth_pilot_ai/business/bucket_transactions_by_period.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';
import 'package:growth_pilot_ai/core/models/profit_margin_point.dart';

/// Net profit margin per period (Issue #350): `(income - expense) / income`
/// as a percentage, sorted chronologically. Unlike the Business Compass axis
/// (#84), this is intentionally unclamped so a loss-making period plots
/// below zero instead of being hidden at 0.
class ComputeProfitMarginSeries {
  static List<ProfitMarginPoint> call(
    List<TransactionEntity> transactions,
    MarginPeriod period,
  ) {
    final buckets = BucketTransactionsByPeriod.call(transactions, period);
    final points = buckets.entries.map((entry) {
      final income = entry.value
          .where((t) => t.type == TransactionType.income)
          .fold(0.0, (sum, t) => sum + t.amount);
      final expense = entry.value
          .where((t) => t.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t.amount);
      final margin = income <= 0 ? 0.0 : ((income - expense) / income) * 100;
      return ProfitMarginPoint(periodStart: entry.key, marginPercent: margin);
    }).toList();

    points.sort((a, b) => a.periodStart.compareTo(b.periodStart));
    return points;
  }
}
