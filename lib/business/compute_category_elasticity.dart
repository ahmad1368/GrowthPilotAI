import 'package:growth_pilot_ai/business/build_category_elasticity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/category_elasticity.dart';

/// Correlates each category's monthly average price against its monthly
/// booking volume (Issue #380) — a local historical-trend proxy for price
/// elasticity, since real elasticity needs a controlled pricing experiment
/// this app has no data for. Categories stand in for "service type", the
/// closest granularity this app's data model supports.
class ComputeCategoryElasticity {
  static List<CategoryElasticity> call(List<TransactionEntity> transactions) {
    final byCategory = <String, List<TransactionEntity>>{};
    for (final t in transactions.where((t) => t.type == TransactionType.income)) {
      final name = t.category.target?.name ?? 'Uncategorized';
      (byCategory[name] ??= []).add(t);
    }

    final results = byCategory.entries
        .map((e) => BuildCategoryElasticity.call(e.key, e.value))
        .toList()
      ..sort((a, b) => a.categoryName.compareTo(b.categoryName));

    return results;
  }
}
