import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_pl_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(double amount) =>
    TransactionEntity(amount: amount, date: DateTime(2026, 1, 1), description: 'in', dbType: 1);

TransactionEntity _expense(double amount, {CategoryEntity? category}) {
  final tx = TransactionEntity(
      amount: amount, date: DateTime(2026, 1, 1), description: 'out', dbType: 0);
  if (category != null) tx.category.target = category;
  return tx;
}

void main() {
  test('sums income and expense, and computes net profit', () {
    final summary = ComputePLSummary.call([_income(1000), _expense(400)]);

    expect(summary.totalIncome, 1000);
    expect(summary.totalExpense, 400);
    expect(summary.netProfit, 600);
  });

  test('groups expenses by category, sorted highest total first', () {
    final rent = CategoryEntity(name: 'Rent');
    final supplies = CategoryEntity(name: 'Supplies');
    final summary = ComputePLSummary.call([
      _expense(200, category: supplies),
      _expense(800, category: rent),
      _expense(100, category: supplies),
    ]);

    expect(summary.expenseByCategory.map((b) => b.categoryName), ['Rent', 'Supplies']);
    expect(summary.expenseByCategory[1].total, 300); // 200 + 100
    expect(summary.expenseByCategory[1].transactions, hasLength(2));
  });

  test('an expense with no category falls under "Uncategorized"', () {
    final summary = ComputePLSummary.call([_expense(50)]);

    expect(summary.expenseByCategory.single.categoryName, 'Uncategorized');
  });

  test('net profit is negative when expenses exceed income', () {
    final summary = ComputePLSummary.call([_income(100), _expense(300)]);

    expect(summary.netProfit, -200);
  });
}
