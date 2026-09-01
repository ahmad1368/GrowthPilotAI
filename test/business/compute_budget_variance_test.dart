import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_budget_variance.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _expense(double amount, DateTime date, CategoryEntity category) {
  final tx =
      TransactionEntity(amount: amount, date: date, description: 'x', dbType: 0);
  tx.category.target = category;
  return tx;
}

void main() {
  final now = DateTime.now().subtract(const Duration(days: 3));

  test('computes actual spend vs. limit for a configured category', () {
    final rent = CategoryEntity(name: 'Rent');
    final results = ComputeBudgetVariance.call(
      [_expense(800, now, rent)],
      [BudgetLimitEntity(categoryName: 'Rent', monthlyLimit: 1000)],
    );

    expect(results.single.actualSpend, 800);
    expect(results.single.limit, 1000);
    expect(results.single.isOverBudget, isFalse);
  });

  test('flags a category as over budget when spend exceeds the limit', () {
    final rent = CategoryEntity(name: 'Rent');
    final results = ComputeBudgetVariance.call(
      [_expense(1200, now, rent)],
      [BudgetLimitEntity(categoryName: 'Rent', monthlyLimit: 1000)],
    );

    expect(results.single.isOverBudget, isTrue);
    expect(results.single.variancePercent, closeTo(20, 0.01));
  });

  test('a category with no matching transactions shows zero spend', () {
    final results = ComputeBudgetVariance.call(
      [],
      [BudgetLimitEntity(categoryName: 'Marketing', monthlyLimit: 500)],
    );

    expect(results.single.actualSpend, 0);
    expect(results.single.isOverBudget, isFalse);
  });

  test('only shows categories with a configured limit', () {
    final rent = CategoryEntity(name: 'Rent');
    final utilities = CategoryEntity(name: 'Utilities');
    final results = ComputeBudgetVariance.call(
      [_expense(100, now, rent), _expense(50, now, utilities)],
      [BudgetLimitEntity(categoryName: 'Rent', monthlyLimit: 200)],
    );

    expect(results, hasLength(1));
    expect(results.single.categoryName, 'Rent');
  });

  test('ranks the worst variance first', () {
    final rent = CategoryEntity(name: 'Rent');
    final utilities = CategoryEntity(name: 'Utilities');
    final results = ComputeBudgetVariance.call(
      [_expense(150, now, rent), _expense(190, now, utilities)],
      [
        BudgetLimitEntity(categoryName: 'Rent', monthlyLimit: 100), // +50%
        BudgetLimitEntity(categoryName: 'Utilities', monthlyLimit: 200), // -5%
      ],
    );

    expect(results.first.categoryName, 'Rent');
  });

  test('no limits configured returns an empty list', () {
    expect(ComputeBudgetVariance.call([], []), isEmpty);
  });
}
