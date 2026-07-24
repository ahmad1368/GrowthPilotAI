import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_seasonal_demand.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'in', dbType: 1);
TransactionEntity _expense(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'out', dbType: 0);

void main() {
  test('always returns exactly 12 points, one per calendar month', () {
    final points = ComputeSeasonalDemand.call([]);
    expect(points, hasLength(12));
    expect(points.map((p) => p.month), List.generate(12, (i) => i + 1));
  });

  test('averages the same month across multiple years instead of summing',
      () {
    final points = ComputeSeasonalDemand.call([
      _income(DateTime(2024, 12, 1), 1000),
      _income(DateTime(2025, 12, 1), 2000),
    ]);

    final december = points.firstWhere((p) => p.month == 12);
    expect(december.averageRevenue, 1500); // (1000+2000)/2, not 3000
  });

  test('flags exactly one month as the peak', () {
    final points = ComputeSeasonalDemand.call([
      _income(DateTime(2026, 1, 1), 100),
      _income(DateTime(2026, 12, 1), 900),
    ]);

    expect(points.where((p) => p.isPeak), hasLength(1));
    expect(points.firstWhere((p) => p.isPeak).month, 12);
  });

  test('ignores expense transactions when computing revenue', () {
    final points = ComputeSeasonalDemand.call([
      _expense(DateTime(2026, 6, 1), 5000),
    ]);

    expect(points.every((p) => p.averageRevenue == 0), isTrue);
  });

  test('no income at all leaves every month at 0 with no peak flagged', () {
    final points = ComputeSeasonalDemand.call([]);
    expect(points.any((p) => p.isPeak), isFalse);
  });
}
