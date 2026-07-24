import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_profit_margin_series.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';

TransactionEntity _income(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'in', dbType: 1);

TransactionEntity _expense(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'out', dbType: 0);

void main() {
  test('computes (income - expense) / income as a percentage', () {
    final series = ComputeProfitMarginSeries.call([
      _income(DateTime(2026, 3, 1), 1000),
      _expense(DateTime(2026, 3, 2), 400),
    ], MarginPeriod.monthly);

    expect(series, hasLength(1));
    expect(series.single.marginPercent, closeTo(60, 0.001)); // (1000-400)/1000
  });

  test('a loss-making period plots as a negative margin, not clamped to 0', () {
    final series = ComputeProfitMarginSeries.call([
      _income(DateTime(2026, 3, 1), 100),
      _expense(DateTime(2026, 3, 2), 300),
    ], MarginPeriod.monthly);

    expect(series.single.marginPercent, closeTo(-200, 0.001));
  });

  test('a period with no income at all reports 0 rather than dividing by zero',
      () {
    final series = ComputeProfitMarginSeries.call(
        [_expense(DateTime(2026, 3, 2), 50)], MarginPeriod.monthly);

    expect(series.single.marginPercent, 0);
  });

  test('is sorted chronologically across multiple periods', () {
    final series = ComputeProfitMarginSeries.call([
      _income(DateTime(2026, 5, 1), 100),
      _income(DateTime(2026, 1, 1), 100),
      _income(DateTime(2026, 3, 1), 100),
    ], MarginPeriod.monthly);

    expect(series.map((p) => p.periodStart.month), [1, 3, 5]);
  });
}
