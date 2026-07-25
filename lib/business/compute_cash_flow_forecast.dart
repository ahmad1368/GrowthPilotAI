import 'package:growth_pilot_ai/business/bucket_transactions_by_period.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';
import 'package:growth_pilot_ai/core/models/cash_flow_projection.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';

/// Projects monthly cash flow 3 months ahead (Issue #368) by running
/// [ForecastEngine]'s linear-regression extrapolation on the income and
/// expense series independently, so each is floored at 0 on its own.
class ComputeCashFlowForecast {
  static const int monthsAhead = 3;
  static const _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static List<CashFlowProjection> call(List<TransactionEntity> transactions) {
    final buckets =
        BucketTransactionsByPeriod.call(transactions, MarginPeriod.monthly);
    if (buckets.isEmpty) return [];

    final sortedMonths = buckets.keys.toList()..sort();
    final incomeSeries = <double>[];
    final expenseSeries = <double>[];
    for (final month in sortedMonths) {
      final txs = buckets[month]!;
      incomeSeries.add(txs
          .where((t) => t.type == TransactionType.income)
          .fold(0.0, (sum, t) => sum + t.amount));
      expenseSeries.add(txs
          .where((t) => t.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t.amount));
    }

    final projectedIncome = ForecastEngine.predictNext(incomeSeries, monthsAhead);
    final projectedExpense = ForecastEngine.predictNext(expenseSeries, monthsAhead);
    final lastMonth = sortedMonths.last;

    return List.generate(monthsAhead, (i) {
      final future = DateTime(lastMonth.year, lastMonth.month + i + 1, 1);
      return CashFlowProjection(
        monthLabel: '${_monthNames[future.month - 1]} ${future.year}',
        projectedInflow: projectedIncome[i],
        projectedOutflow: projectedExpense[i],
      );
    });
  }
}
