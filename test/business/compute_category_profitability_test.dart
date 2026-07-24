import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_category_profitability.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _tx(double amount, {required bool income, CategoryEntity? category}) {
  final tx = TransactionEntity(
      amount: amount, date: DateTime(2026, 1, 1), description: 'x', dbType: income ? 1 : 0);
  if (category != null) tx.category.target = category;
  return tx;
}

void main() {
  test('nets income minus expense per category', () {
    final consulting = CategoryEntity(name: 'Consulting');
    final results = ComputeCategoryProfitability.call([
      _tx(1000, income: true, category: consulting),
      _tx(300, income: false, category: consulting),
    ]);

    expect(results.single.categoryName, 'Consulting');
    expect(results.single.netProfit, 700);
  });

  test('ranks categories highest net profit first', () {
    final gold = CategoryEntity(name: 'Gold Tier');
    final bronze = CategoryEntity(name: 'Bronze Tier');
    final results = ComputeCategoryProfitability.call([
      _tx(500, income: true, category: bronze),
      _tx(400, income: false, category: bronze), // net 100
      _tx(2000, income: true, category: gold),
      _tx(200, income: false, category: gold), // net 1800
    ]);

    expect(results.map((r) => r.categoryName), ['Gold Tier', 'Bronze Tier']);
  });

  test('a category with only expenses shows as a negative net profit', () {
    final overhead = CategoryEntity(name: 'Overhead');
    final results = ComputeCategoryProfitability.call(
        [_tx(500, income: false, category: overhead)]);

    expect(results.single.netProfit, -500);
  });

  test('an uncategorized transaction falls under "Uncategorized"', () {
    final results = ComputeCategoryProfitability.call([_tx(100, income: true)]);

    expect(results.single.categoryName, 'Uncategorized');
  });
}
