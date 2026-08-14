import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

/// Sums income transactions over a trailing window as the revenue
/// input to [ComputeMicroCreditLimit] (Issue #419, acceptance
/// criterion 1).
class ComputeTrailingRevenue {
  static double call(List<TransactionEntity> transactions, DateTime now, {int windowDays = 90}) {
    final start = now.subtract(Duration(days: windowDays));
    return transactions
        .where((t) => t.dbType == TransactionType.income.index && !t.date.isBefore(start))
        .fold<double>(0, (sum, t) => sum + t.amount);
  }
}
