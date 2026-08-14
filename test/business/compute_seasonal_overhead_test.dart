import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_seasonal_overhead.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'in', dbType: 1);
TransactionEntity _expense(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'out', dbType: 0);

void main() {
  test('always returns exactly 12 points, one per calendar month', () {
    final points = ComputeSeasonalOverhead.call([]);
    expect(points, hasLength(12));
    expect(points.map((p) => p.month), List.generate(12, (i) => i + 1));
  });

  test('averages the same month across multiple years instead of summing', () {
    final points = ComputeSeasonalOverhead.call([
      _expense(DateTime(2024, 1, 1), 400),
      _expense(DateTime(2025, 1, 1), 800),
    ]);

    final january = points.firstWhere((p) => p.month == 1);
    expect(january.averageExpense, 600); // (400+800)/2, not 1200
  });

  test('flags exactly one month as the peak', () {
    final points = ComputeSeasonalOverhead.call([
      _expense(DateTime(2026, 1, 1), 100),
      _expense(DateTime(2026, 7, 1), 900),
    ]);

    expect(points.where((p) => p.isPeak), hasLength(1));
    expect(points.firstWhere((p) => p.isPeak).month, 7);
  });

  test('ignores income transactions when computing overhead', () {
    final points = ComputeSeasonalOverhead.call([
      _income(DateTime(2026, 6, 1), 5000),
    ]);

    expect(points.every((p) => p.averageExpense == 0), isTrue);
  });

  test('no expenses at all leaves every month at 0 with no peak flagged', () {
    final points = ComputeSeasonalOverhead.call([]);
    expect(points.any((p) => p.isPeak), isFalse);
  });
}
