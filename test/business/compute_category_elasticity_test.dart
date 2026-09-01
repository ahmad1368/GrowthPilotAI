import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_category_elasticity.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/category_elasticity.dart';

TransactionEntity _tx(double amount, DateTime date, {CategoryEntity? category}) {
  final tx =
      TransactionEntity(amount: amount, date: date, description: 'x', dbType: 1);
  if (category != null) tx.category.target = category;
  return tx;
}

void main() {
  test('flags a category as elastic when rising price coincides with falling volume', () {
    final consulting = CategoryEntity(name: 'Consulting');
    final transactions = [
      _tx(100, DateTime(2026, 1, 1), category: consulting),
      _tx(100, DateTime(2026, 1, 5), category: consulting),
      _tx(100, DateTime(2026, 1, 10), category: consulting),
      _tx(200, DateTime(2026, 2, 1), category: consulting),
    ];

    final results = ComputeCategoryElasticity.call(transactions);

    expect(results.single.hint, ElasticityHint.elastic);
  });

  test('flags a category as inelastic when volume holds despite rising price', () {
    final repairs = CategoryEntity(name: 'Repairs');
    final transactions = [
      _tx(100, DateTime(2026, 1, 1), category: repairs),
      _tx(200, DateTime(2026, 2, 1), category: repairs),
      _tx(200, DateTime(2026, 2, 5), category: repairs),
    ];

    final results = ComputeCategoryElasticity.call(transactions);

    expect(results.single.hint, ElasticityHint.inelastic);
  });

  test('flags insufficient with fewer than 2 months of history', () {
    final repairs = CategoryEntity(name: 'Repairs');
    final results = ComputeCategoryElasticity.call([
      _tx(100, DateTime(2026, 1, 1), category: repairs),
    ]);

    expect(results.single.hint, ElasticityHint.insufficient);
  });

  test('sorts categories alphabetically', () {
    final zeta = CategoryEntity(name: 'Zeta');
    final alpha = CategoryEntity(name: 'Alpha');
    final results = ComputeCategoryElasticity.call([
      _tx(100, DateTime(2026, 1, 1), category: zeta),
      _tx(100, DateTime(2026, 1, 1), category: alpha),
    ]);

    expect(results.map((r) => r.categoryName), ['Alpha', 'Zeta']);
  });

  test('an uncategorized transaction falls under "Uncategorized"', () {
    final results = ComputeCategoryElasticity.call([_tx(100, DateTime(2026, 1, 1))]);
    expect(results.single.categoryName, 'Uncategorized');
  });

  test('no income transactions returns an empty list', () {
    expect(ComputeCategoryElasticity.call([]), isEmpty);
  });
}
