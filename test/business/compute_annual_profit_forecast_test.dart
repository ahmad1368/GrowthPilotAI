import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_annual_profit_forecast.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _tx(double amount, DateTime date, {required bool income}) =>
    TransactionEntity(
        amount: amount, date: date, description: 'x', dbType: income ? 1 : 0);

void main() {
  test('a flat income/expense history projects a flat profit times 12 months', () {
    final transactions = [
      _tx(1000, DateTime(2026, 1, 10), income: true),
      _tx(300, DateTime(2026, 1, 10), income: false),
      _tx(1000, DateTime(2026, 2, 10), income: true),
      _tx(300, DateTime(2026, 2, 10), income: false),
    ];

    final forecast = ComputeAnnualProfitForecast.call(transactions);

    expect(forecast, isNotNull);
    expect(forecast!.expectedAnnualProfit, closeTo(700 * 12, 0.01));
    expect(forecast.peakMonthLabel, 'Mar 2026');
  });

  test('a positive expected profit puts the best case above the expected total', () {
    final transactions = [
      _tx(1000, DateTime(2026, 1, 10), income: true),
      _tx(300, DateTime(2026, 1, 10), income: false),
      _tx(1000, DateTime(2026, 2, 10), income: true),
      _tx(300, DateTime(2026, 2, 10), income: false),
    ];

    final forecast = ComputeAnnualProfitForecast.call(transactions)!;

    expect(forecast.bestCaseAnnualProfit, greaterThan(forecast.expectedAnnualProfit));
    expect(forecast.worstCaseAnnualProfit, lessThan(forecast.expectedAnnualProfit));
  });

  test('a negative expected profit keeps the best case closer to zero than the worst case', () {
    final transactions = [
      _tx(300, DateTime(2026, 1, 10), income: true),
      _tx(1000, DateTime(2026, 1, 10), income: false),
      _tx(300, DateTime(2026, 2, 10), income: true),
      _tx(1000, DateTime(2026, 2, 10), income: false),
    ];

    final forecast = ComputeAnnualProfitForecast.call(transactions)!;

    expect(forecast.expectedAnnualProfit, lessThan(0));
    expect(forecast.bestCaseAnnualProfit, greaterThan(forecast.worstCaseAnnualProfit));
    expect(forecast.bestCaseAnnualProfit, greaterThan(forecast.expectedAnnualProfit));
  });

  test('an empty transaction list returns no forecast', () {
    expect(ComputeAnnualProfitForecast.call([]), isNull);
  });
}
