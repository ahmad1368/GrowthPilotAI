import '../../../../objectbox.g.dart';
import '../entities/budget_limit_entity.dart';

/// CRUD for merchant-configured budget limits (Issue #383).
class BudgetLimitRepository {
  final Box<BudgetLimitEntity> _box;

  BudgetLimitRepository(this._box);

  List<BudgetLimitEntity> getAll() => _box.getAll();

  /// Inserts a new limit or updates the existing one for [categoryName],
  /// since [BudgetLimitEntity.categoryName] is unique.
  int upsert(String categoryName, double monthlyLimit) {
    final query =
        _box.query(BudgetLimitEntity_.categoryName.equals(categoryName)).build();
    final existing = query.findFirst();
    query.close();

    final entry = BudgetLimitEntity(
      id: existing?.id ?? 0,
      categoryName: categoryName,
      monthlyLimit: monthlyLimit,
    );
    return _box.put(entry);
  }
}
