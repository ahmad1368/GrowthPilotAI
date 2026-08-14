import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_overhead_breakdown.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _tx(double amount, {required bool income, CategoryEntity? category}) {
  final tx = TransactionEntity(
      amount: amount, date: DateTime(2026, 1, 1), description: 'x', dbType: income ? 1 : 0);
  if (category != null) tx.category.target = category;
  return tx;
}

void main() {
  test('computes each expense category ratio against total revenue', () {
    final rent = CategoryEntity(name: 'Rent');
    final results = ComputeOverheadBreakdown.call([
      _tx(1000, income: true),
      _tx(200, income: false, category: rent),
    ]);

    expect(results.single.categoryName, 'Rent');
    expect(results.single.ratioToRevenue, 0.2);
  });

  test('ranks categories highest ratio-to-revenue first', () {
    final rent = CategoryEntity(name: 'Rent');
    final utilities = CategoryEntity(name: 'Utilities');
    final results = ComputeOverheadBreakdown.call([
      _tx(1000, income: true),
      _tx(100, income: false, category: utilities), // 10%
      _tx(400, income: false, category: rent), // 40%
    ]);

    expect(results.map((r) => r.categoryName), ['Rent', 'Utilities']);
  });

  test('flags a category past the alert threshold as over budget', () {
    final rent = CategoryEntity(name: 'Rent');
    final results = ComputeOverheadBreakdown.call([
      _tx(1000, income: true),
      _tx(200, income: false, category: rent), // 20% > 15% threshold
    ]);

    expect(results.single.isOverBudget, isTrue);
  });

  test('a category under the alert threshold is not flagged', () {
    final utilities = CategoryEntity(name: 'Utilities');
    final results = ComputeOverheadBreakdown.call([
      _tx(1000, income: true),
      _tx(100, income: false, category: utilities), // 10% < 15% threshold
    ]);

    expect(results.single.isOverBudget, isFalse);
  });

  test('zero revenue yields a zero ratio instead of dividing by zero', () {
    final rent = CategoryEntity(name: 'Rent');
    final results =
        ComputeOverheadBreakdown.call([_tx(200, income: false, category: rent)]);

    expect(results.single.ratioToRevenue, 0.0);
    expect(results.single.isOverBudget, isFalse);
  });

  test('an uncategorized expense falls under "Uncategorized"', () {
    final results = ComputeOverheadBreakdown.call([
      _tx(1000, income: true),
      _tx(100, income: false),
    ]);

    expect(results.single.categoryName, 'Uncategorized');
  });

  test('no expenses returns an empty list', () {
    final results = ComputeOverheadBreakdown.call([_tx(1000, income: true)]);
    expect(results, isEmpty);
  });
}
