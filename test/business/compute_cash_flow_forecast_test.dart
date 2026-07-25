import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_cash_flow_forecast.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _tx(double amount, DateTime date, {required bool income}) =>
    TransactionEntity(
        amount: amount, date: date, description: 'x', dbType: income ? 1 : 0);

void main() {
  test('projects exactly 3 months ahead of the last historical month', () {
    final transactions = [
      _tx(1000, DateTime(2026, 1, 15), income: true),
      _tx(400, DateTime(2026, 1, 20), income: false),
      _tx(1000, DateTime(2026, 2, 15), income: true),
      _tx(400, DateTime(2026, 2, 20), income: false),
    ];

    final result = ComputeCashFlowForecast.call(transactions);

    expect(result, hasLength(3));
    expect(result.map((p) => p.monthLabel), ['Mar 2026', 'Apr 2026', 'May 2026']);
  });

  test('a flat income/expense history projects the same flat values forward', () {
    final transactions = [
      _tx(1000, DateTime(2026, 1, 10), income: true),
      _tx(300, DateTime(2026, 1, 10), income: false),
      _tx(1000, DateTime(2026, 2, 10), income: true),
      _tx(300, DateTime(2026, 2, 10), income: false),
    ];

    final result = ComputeCashFlowForecast.call(transactions);

    for (final p in result) {
      expect(p.projectedInflow, 1000);
      expect(p.projectedOutflow, 300);
      expect(p.isDeficit, isFalse);
    }
  });

  test('flags a projected month as a deficit when outflow exceeds inflow', () {
    final transactions = [
      _tx(1000, DateTime(2026, 1, 5), income: true),
      _tx(100, DateTime(2026, 1, 5), income: false),
      _tx(500, DateTime(2026, 2, 5), income: true),
      _tx(900, DateTime(2026, 2, 5), income: false),
    ];

    final result = ComputeCashFlowForecast.call(transactions);

    expect(result.first.isDeficit, isTrue);
    expect(result.first.projectedNet, lessThan(0));
  });

  test('an empty transaction list returns no projections', () {
    expect(ComputeCashFlowForecast.call([]), isEmpty);
  });

  test('fewer than 2 historical months floors every projection at 0', () {
    final transactions = [_tx(1000, DateTime(2026, 1, 5), income: true)];

    final result = ComputeCashFlowForecast.call(transactions);

    expect(result, hasLength(3));
    for (final p in result) {
      expect(p.projectedInflow, 0.0);
      expect(p.projectedOutflow, 0.0);
    }
  });
}
