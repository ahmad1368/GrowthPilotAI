import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/churn_cohort_point.dart';

/// Buckets transactions into the trailing [weekCount] weekly cohorts
/// (Issue #357), most recent last, so the chart reads left-to-right.
class ComputeChurnCohortPoints {
  static const weekCount = 8;

  static List<ChurnCohortPoint> call(
    List<TransactionEntity> transactions,
    DateTime now,
  ) {
    return [
      for (var w = weekCount - 1; w >= 0; w--)
        ChurnCohortPoint(
          weeksAgo: w,
          count: transactions.where((t) {
            final weekStart = now.subtract(Duration(days: (w + 1) * 7));
            final weekEnd = now.subtract(Duration(days: w * 7));
            return t.date.isAfter(weekStart) && !t.date.isAfter(weekEnd);
          }).length,
        ),
    ];
  }
}
