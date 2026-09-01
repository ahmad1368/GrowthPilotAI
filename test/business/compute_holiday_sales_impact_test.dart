import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_holiday_sales_impact.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(DateTime date, double amount) =>
    TransactionEntity(amount: amount, date: date, description: 'x', dbType: 1);

void main() {
  test('flags a holiday with a large lift as positive', () {
    final transactions = [
      // Ordinary days: $10/day baseline.
      for (var d = 1; d <= 20; d++) _income(DateTime(2026, 3, d), 10),
      // Canada Day window (Jun30-Jul2): much higher.
      _income(DateTime(2026, 6, 30), 100),
      _income(DateTime(2026, 7, 1), 100),
      _income(DateTime(2026, 7, 2), 100),
    ];

    final results = ComputeHolidaySalesImpact.call(transactions);
    final canadaDay = results.firstWhere((r) => r.holidayName == 'Canada Day');

    expect(canadaDay.liftPercent, greaterThan(0));
  });

  test('a holiday with no matching transactions is excluded entirely', () {
    final transactions = [_income(DateTime(2026, 3, 15), 50)];

    final results = ComputeHolidaySalesImpact.call(transactions);

    expect(results, isEmpty);
  });

  test('ranks the biggest lift first', () {
    final transactions = [
      for (var d = 1; d <= 10; d++) _income(DateTime(2026, 3, d), 10),
      _income(DateTime(2026, 1, 1), 15), // New Year's: small lift
      _income(DateTime(2026, 12, 25), 500), // Christmas: huge lift
    ];

    final results = ComputeHolidaySalesImpact.call(transactions);

    expect(results.first.holidayName, "Christmas Day");
  });

  test('no income transactions at all returns an empty list', () {
    expect(ComputeHolidaySalesImpact.call([]), isEmpty);
  });
}
