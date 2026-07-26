import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/regional_affordability_result.dart';
import 'package:growth_pilot_ai/core/utils/analytics_utils.dart';

/// Compares the average local basket price against a regional purchasing
/// power benchmark (Issue #397). This app has no census/demographic feed,
/// so [medianMonthlyDisposableIncome] is a documented static reference
/// (Metro Vancouver median household disposable income, same category as
/// the mocked sector benchmarks and statutory-holiday calendar elsewhere
/// in this app), not a live regional lookup.
class ComputeRegionalAffordability {
  static const medianMonthlyDisposableIncome = 4200.0;
  static const underpricedCeiling = 2.0;
  static const alignedCeiling = 8.0;

  static RegionalAffordabilityResult call(List<TransactionEntity> transactions) {
    final basketPrices = transactions
        .where((t) => t.type == TransactionType.income)
        .map((t) => t.amount)
        .toList();
    final averageBasketPrice = AnalyticsUtils.calculateAverage(basketPrices);
    final index = medianMonthlyDisposableIncome == 0
        ? 0.0
        : double.parse(
            (averageBasketPrice / medianMonthlyDisposableIncome * 100).toStringAsFixed(2));

    final tier = index <= underpricedCeiling
        ? AffordabilityTier.underpriced
        : (index <= alignedCeiling ? AffordabilityTier.aligned : AffordabilityTier.overpriced);

    return RegionalAffordabilityResult(
      averageBasketPrice: averageBasketPrice,
      medianMonthlyIncome: medianMonthlyDisposableIncome,
      affordabilityIndex: index,
      tier: tier,
    );
  }
}
