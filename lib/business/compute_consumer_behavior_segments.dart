import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/consumer_behavior_insight.dart';
import 'package:growth_pilot_ai/core/utils/analytics_utils.dart';

/// Segments income transactions against a documented low-income spending
/// profile (Issue #353) — this app has no census/demographic feed, so
/// [budgetFriendlyCeiling] is a documented static reference (a per-visit
/// spend a Statistics Canada low-income household budgets for), the same
/// category as the mocked sector benchmarks and regional affordability
/// threshold elsewhere in this app.
class ComputeConsumerBehaviorSegments {
  static const budgetFriendlyCeiling = 25.0;
  static const strongFitFloor = 60.0;
  static const moderateFitFloor = 30.0;

  static ConsumerBehaviorInsight call(List<TransactionEntity> transactions) {
    final sales = transactions.where((t) => t.type == TransactionType.income).toList();
    final basketPrices = sales.map((t) => t.amount).toList();
    final averageBasketSize = AnalyticsUtils.calculateAverage(basketPrices);

    final budgetFriendlyCount =
        basketPrices.where((price) => price <= budgetFriendlyCeiling).length;
    final budgetFriendlyShare = basketPrices.isEmpty
        ? 0.0
        : double.parse(
            (budgetFriendlyCount / basketPrices.length * 100).toStringAsFixed(2));

    final visitFrequencyPerWeek = _visitFrequencyPerWeek(sales);

    final fitTier = budgetFriendlyShare >= strongFitFloor
        ? LowIncomeFitTier.strong
        : budgetFriendlyShare >= moderateFitFloor
            ? LowIncomeFitTier.moderate
            : LowIncomeFitTier.weak;

    return ConsumerBehaviorInsight(
      averageBasketSize: averageBasketSize,
      visitFrequencyPerWeek: visitFrequencyPerWeek,
      budgetFriendlyShare: budgetFriendlyShare,
      fitTier: fitTier,
    );
  }

  static double _visitFrequencyPerWeek(List<TransactionEntity> sales) {
    if (sales.isEmpty) return 0.0;
    final visitDays = sales.map((t) =>
        DateTime(t.date.year, t.date.month, t.date.day)).toSet();
    final sortedDays = visitDays.toList()..sort();
    final spanDays = sortedDays.last.difference(sortedDays.first).inDays + 1;
    final weekSpan = spanDays / 7;
    return double.parse(
        (visitDays.length / (weekSpan < 1 ? 1 : weekSpan)).toStringAsFixed(2));
  }
}
