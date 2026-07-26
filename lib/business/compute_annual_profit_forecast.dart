import 'package:growth_pilot_ai/business/bucket_transactions_by_period.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';
import 'package:growth_pilot_ai/core/models/annual_profit_forecast.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';

/// Projects profit 12 months ahead (Issue #399) via [ForecastEngine]'s
/// linear-regression extrapolation on income/expense, same engine as
/// [ComputeCashFlowForecast] but annualized and expressed as profit. No
/// macroeconomic-indicator feed exists in this app, so the best/worst-case
/// bands are a documented static +/-15% heuristic around the expected
/// trend line, not a live economic model.
class ComputeAnnualProfitForecast {
  static const monthsAhead = 12;
  static const bestCaseMultiplier = 1.15;
  static const worstCaseMultiplier = 0.85;
  static const _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static AnnualProfitForecast? call(List<TransactionEntity> transactions) {
    final buckets = BucketTransactionsByPeriod.call(transactions, MarginPeriod.monthly);
    if (buckets.isEmpty) return null;

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

    var expectedTotal = 0.0;
    var peakIndex = 0;
    var peakProfit = double.negativeInfinity;
    for (var i = 0; i < monthsAhead; i++) {
      final profit = projectedIncome[i] - projectedExpense[i];
      expectedTotal += profit;
      if (profit > peakProfit) {
        peakProfit = profit;
        peakIndex = i;
      }
    }
    final peakMonth = DateTime(lastMonth.year, lastMonth.month + peakIndex + 1, 1);
    // A negative expected profit means the "optimistic" multiplier is the
    // one closer to zero, not the larger one - flip which multiplier makes
    // the total larger/smaller so best/worst stay correctly ordered.
    final betterMultiplier = expectedTotal >= 0 ? bestCaseMultiplier : worstCaseMultiplier;
    final worseMultiplier = expectedTotal >= 0 ? worstCaseMultiplier : bestCaseMultiplier;

    return AnnualProfitForecast(
      expectedAnnualProfit: double.parse(expectedTotal.toStringAsFixed(2)),
      bestCaseAnnualProfit:
          double.parse((expectedTotal * betterMultiplier).toStringAsFixed(2)),
      worstCaseAnnualProfit:
          double.parse((expectedTotal * worseMultiplier).toStringAsFixed(2)),
      peakMonthLabel: '${_monthNames[peakMonth.month - 1]} ${peakMonth.year}',
    );
  }
}
