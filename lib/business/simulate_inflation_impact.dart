import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/inflation_impact_scenario.dart';

/// Simulates the margin impact of a reference inflation rate on current
/// income/expense (Issue #373). [referenceInflationRate] is a documented
/// static illustrative figure — this app has no live macroeconomic
/// CPI/inflation-index feed, the same mocked-benchmark pattern used for
/// the Business Compass sector benchmarks (#84).
class SimulateInflationImpact {
  static const double referenceInflationRate = 0.032;

  static List<InflationImpactScenario> call(List<TransactionEntity> transactions) {
    final income = transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
    final expense = transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
    if (income <= 0 && expense <= 0) return [];

    final currentMargin = income <= 0 ? 0.0 : ((income - expense) / income) * 100;

    final absorbedExpense = expense * (1 + referenceInflationRate);
    final absorbedMargin =
        income <= 0 ? 0.0 : ((income - absorbedExpense) / income) * 100;

    final passIncome = income * (1 + referenceInflationRate);
    final passExpense = expense * (1 + referenceInflationRate);
    final passMargin =
        passIncome <= 0 ? 0.0 : ((passIncome - passExpense) / passIncome) * 100;

    return [
      InflationImpactScenario(
        scenarioName: 'Current',
        projectedIncome: income,
        projectedExpense: expense,
        projectedMarginPercent: currentMargin,
      ),
      InflationImpactScenario(
        scenarioName: 'Absorb Cost Increase',
        projectedIncome: income,
        projectedExpense: absorbedExpense,
        projectedMarginPercent: absorbedMargin,
      ),
      InflationImpactScenario(
        scenarioName: 'Pass Through to Prices',
        projectedIncome: passIncome,
        projectedExpense: passExpense,
        projectedMarginPercent: passMargin,
      ),
    ];
  }
}
