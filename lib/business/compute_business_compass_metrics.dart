import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/domain/business/financial_analytics_processor.dart';

/// Client-side approximation of the NestJS `SuccessSignatureService`'s
/// feature extraction (Issue #84): normalizes the user's own transaction
/// data into the same 5-axis vector shape as [GetSectorBenchmark], since no
/// backend "Financial DNA" pipeline exists in this repo.
///
/// Two data-model gaps mean two of the five axes are approximations rather
/// than the issue's literal definitions: [paymentPunctuality] has no
/// invoice due-date field to measure against, so it proxies "already
/// synced" transactions; [burnVelocity] compares the two halves of
/// [transactions]' own date range rather than a separate prior period.
class ComputeBusinessCompassMetrics {
  static BusinessCompassMetrics call(List<TransactionEntity> transactions) {
    if (transactions.isEmpty) {
      return const BusinessCompassMetrics(
        liquidityRatio: 0,
        burnVelocity: 0.5,
        vendorDiversity: 0,
        paymentPunctuality: 0,
        profitMargin: 0,
      );
    }

    final income = transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
    final expense = transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);

    return BusinessCompassMetrics(
      liquidityRatio: _liquidityRatio(income, expense),
      burnVelocity: _burnVelocity(transactions),
      vendorDiversity: _vendorDiversity(transactions),
      paymentPunctuality: _paymentPunctuality(transactions),
      profitMargin: _profitMargin(income, expense),
    );
  }

  static double _liquidityRatio(double income, double expense) {
    if (expense <= 0) return income > 0 ? 1.0 : 0.0;
    return (income / expense / 2.0).clamp(0.0, 1.0);
  }

  static double _profitMargin(double income, double expense) {
    if (income <= 0) return 0.0;
    return ((income - expense) / income).clamp(0.0, 1.0);
  }

  static double _vendorDiversity(List<TransactionEntity> transactions) {
    final vendorIds = transactions.map((t) => t.vendor.target?.id ?? 0).toSet();
    return (vendorIds.length / transactions.length).clamp(0.0, 1.0);
  }

  static double _paymentPunctuality(List<TransactionEntity> transactions) {
    final synced =
        transactions.where((t) => t.syncStatus == SyncStatus.synced).length;
    return (synced / transactions.length).clamp(0.0, 1.0);
  }

  static double _burnVelocity(List<TransactionEntity> transactions) {
    final sorted = [...transactions]..sort((a, b) => a.date.compareTo(b.date));
    final mid = sorted.length ~/ 2;
    if (mid == 0) return 0.5;

    final comparison = FinancialAnalyticsProcessor.processComparison(
      currentRaw: sorted.sublist(mid),
      previousRaw: sorted.sublist(0, mid),
      type: TransactionType.expense,
    );
    // Slower expense growth (or shrinking spend) scores higher; scaled so a
    // +/-100% swing moves the score by 0.5 from its 0.5 "flat" baseline.
    return (0.5 - comparison.percentageChange / 200).clamp(0.0, 1.0);
  }
}
