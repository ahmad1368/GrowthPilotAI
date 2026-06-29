import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/financial_comparison.dart';
import 'package:growth_pilot_ai/core/utils/analytics_utils.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

class FinancialAnalyticsProcessor {
  static FinancialComparison processComparison({
    required List<TransactionEntity> currentRaw,
    required List<TransactionEntity> previousRaw,
    required TransactionType type,
  }) {
    try {
      final currentAmounts =
          currentRaw.where((e) => e.type == type).map((e) => e.amount).toList();
      final previousAmounts = previousRaw
          .where((e) => e.type == type)
          .map((e) => e.amount)
          .toList();

      return AnalyticsUtils.comparePeriods(
        currentAmounts,
        previousAmounts,
        type == TransactionType.expense,
      );
    } catch (e, stack) {
      OmniLogger.error(
        title: "خطای پردازشگر آنالیتیکس مالی",
        message: "خطا در فیلترینگ یا محاسبه دوره‌ای | User: Ahmad_Salem_Pour",
        stackTrace: stack,
        widgetName: "FinancialAnalyticsProcessor",
      );
      return const FinancialComparison(
          totalDifference: 0, percentageChange: 0, isNegativeTrend: false);
    }
  }
}
