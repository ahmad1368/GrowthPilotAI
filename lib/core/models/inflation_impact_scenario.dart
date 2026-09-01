import 'package:flutter/foundation.dart';

/// One inflation-impact scenario's projected income/expense/margin (Issue
/// #373).
@immutable
class InflationImpactScenario {
  final String scenarioName;
  final double projectedIncome;
  final double projectedExpense;
  final double projectedMarginPercent;

  const InflationImpactScenario({
    required this.scenarioName,
    required this.projectedIncome,
    required this.projectedExpense,
    required this.projectedMarginPercent,
  });
}
