import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/compass_period.dart';
import 'package:growth_pilot_ai/core/models/budget_variance.dart';
import 'package:growth_pilot_ai/business/filter_transactions_by_period.dart';

/// Compares each configured [BudgetLimitEntity] against the trailing-30-day
/// actual spend in that category (Issue #383) — only categories a merchant
/// has actually set a limit for are shown, since limits are opt-in.
class ComputeBudgetVariance {
  static List<BudgetVariance> call(
    List<TransactionEntity> transactions,
    List<BudgetLimitEntity> limits,
  ) {
    final windowed =
        FilterTransactionsByPeriod.call(transactions, CompassPeriod.monthly, DateTime.now());

    final spendByCategory = <String, double>{};
    for (final t in windowed.where((t) => t.type == TransactionType.expense)) {
      final name = t.category.target?.name ?? 'Uncategorized';
      spendByCategory[name] = (spendByCategory[name] ?? 0) + t.amount;
    }

    return limits
        .map((l) => BudgetVariance(
              categoryName: l.categoryName,
              limit: l.monthlyLimit,
              actualSpend: spendByCategory[l.categoryName] ?? 0.0,
            ))
        .toList()
      ..sort((a, b) => b.variancePercent.compareTo(a.variancePercent));
  }
}
