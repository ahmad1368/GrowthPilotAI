import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/simulate_inflation_impact.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _tx(double amount, {required bool income}) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'x', dbType: income ? 1 : 0);

void main() {
  test('returns 3 scenarios: current, absorb, pass-through', () {
    final scenarios = SimulateInflationImpact.call([
      _tx(1000, income: true),
      _tx(500, income: false),
    ]);

    expect(scenarios.map((s) => s.scenarioName),
        ['Current', 'Absorb Cost Increase', 'Pass Through to Prices']);
  });

  test('absorbing the cost increase raises expense and lowers margin', () {
    final scenarios = SimulateInflationImpact.call([
      _tx(1000, income: true),
      _tx(500, income: false),
    ]);

    final current = scenarios[0];
    final absorb = scenarios[1];
    expect(absorb.projectedIncome, current.projectedIncome);
    expect(absorb.projectedExpense, greaterThan(current.projectedExpense));
    expect(absorb.projectedMarginPercent, lessThan(current.projectedMarginPercent));
  });

  test('passing the increase through to prices preserves the margin percent', () {
    final scenarios = SimulateInflationImpact.call([
      _tx(1000, income: true),
      _tx(500, income: false),
    ]);

    final current = scenarios[0];
    final passThrough = scenarios[2];
    expect(passThrough.projectedMarginPercent, closeTo(current.projectedMarginPercent, 0.01));
    expect(passThrough.projectedIncome, greaterThan(current.projectedIncome));
  });

  test('applies exactly the documented reference rate', () {
    final scenarios = SimulateInflationImpact.call([_tx(500, income: false)]);
    final absorb = scenarios[1];

    expect(absorb.projectedExpense,
        closeTo(500 * (1 + SimulateInflationImpact.referenceInflationRate), 0.001));
  });

  test('no income or expense at all returns no scenarios', () {
    expect(SimulateInflationImpact.call([]), isEmpty);
  });
}
