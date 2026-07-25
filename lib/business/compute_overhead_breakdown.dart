import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/overhead_category.dart';

/// Ranks expense categories by their share of total revenue (Issue #367).
///
/// [alertThreshold] is a documented default "budget variance" flag (15% of
/// revenue) standing in for a real per-category budget limit — this app has
/// no such data model, only category-tagged transactions.
class ComputeOverheadBreakdown {
  static const double alertThreshold = 0.15;

  static List<OverheadCategory> call(List<TransactionEntity> transactions) {
    final income = transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);

    final byCategory = <String, double>{};
    for (final t in transactions.where((t) => t.type == TransactionType.expense)) {
      final name = t.category.target?.name ?? 'Uncategorized';
      byCategory[name] = (byCategory[name] ?? 0) + t.amount;
    }

    final results = byCategory.entries.map((e) {
      final ratio = income <= 0 ? 0.0 : e.value / income;
      return OverheadCategory(
        categoryName: e.key,
        expense: e.value,
        ratioToRevenue: ratio,
        isOverBudget: ratio > alertThreshold,
      );
    }).toList()
      ..sort((a, b) => b.ratioToRevenue.compareTo(a.ratioToRevenue));

    return results;
  }
}
