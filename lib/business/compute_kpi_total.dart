import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

/// Sums matching transactions for the KPI Card view (Issue #261).
class ComputeKpiTotal {
  static double call(List<TransactionEntity> transactions) {
    return transactions.fold<double>(0, (sum, t) => sum + t.amount);
  }
}
