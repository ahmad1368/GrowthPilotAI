import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/category_profitability.dart';

/// Ranks categories by net profit contribution, highest first (Issue
/// #361) — the item/service-level breakdown the issue asks for, scoped to
/// this app's actual category granularity (see [CategoryProfitability]).
class ComputeCategoryProfitability {
  static List<CategoryProfitability> call(List<TransactionEntity> transactions) {
    final byCategory = <String, List<TransactionEntity>>{};
    for (final t in transactions) {
      final name = t.category.target?.name ?? 'Uncategorized';
      (byCategory[name] ??= []).add(t);
    }

    final results = byCategory.entries.map((e) {
      final income = e.value
          .where((t) => t.type == TransactionType.income)
          .fold(0.0, (sum, t) => sum + t.amount);
      final expense = e.value
          .where((t) => t.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t.amount);
      return CategoryProfitability(
          categoryName: e.key, income: income, expense: expense);
    }).toList()
      ..sort((a, b) => b.netProfit.compareTo(a.netProfit));

    return results;
  }
}
