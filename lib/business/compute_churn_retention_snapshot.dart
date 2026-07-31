import 'package:growth_pilot_ai/business/compute_churn_cohort_points.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/churn_retention_snapshot.dart';

/// Retention rate for the selected inactivity window (Issue #357): the
/// merchant-customizable "churn definition parameter" is [period] itself,
/// comparing transaction volume to the equal-length window before it —
/// each transaction stands in for a customer visit, since this app has no
/// dedicated customer/CRM entity to track individual purchase gaps with.
class ComputeChurnRetentionSnapshot {
  static const churnRiskThreshold = 0.7;

  static ChurnRetentionSnapshot call(
    List<TransactionEntity> transactions,
    DateTime now,
    Duration period,
  ) {
    final currentStart = now.subtract(period);
    final previousStart = now.subtract(period * 2);

    final currentCount =
        transactions.where((t) => t.date.isAfter(currentStart)).length;
    final previousCount = transactions
        .where((t) =>
            t.date.isAfter(previousStart) && !t.date.isAfter(currentStart))
        .length;

    final retentionRate = previousCount <= 0
        ? (currentCount > 0 ? 1.0 : 0.0)
        : (currentCount / previousCount).clamp(0.0, 1.0);

    return ChurnRetentionSnapshot(
      currentPeriodCount: currentCount,
      previousPeriodCount: previousCount,
      retentionRate: retentionRate,
      isChurnRisk: retentionRate < churnRiskThreshold,
      cohortPoints: ComputeChurnCohortPoints.call(transactions, now),
    );
  }
}
