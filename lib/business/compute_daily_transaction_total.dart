import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

/// Sums every non-deleted transaction logged on [day] (Issue #344,
/// acceptance criterion 1) — this app has no per-merchant transaction
/// split, so the cap applies to this business's own daily total,
/// reusing the existing [TransactionEntity] log rather than a new one.
class ComputeDailyTransactionTotal {
  static double call(List<TransactionEntity> transactions, DateTime day) {
    return transactions
        .where((t) =>
            !t.isDeleted &&
            t.date.year == day.year &&
            t.date.month == day.month &&
            t.date.day == day.day)
        .fold(0.0, (sum, t) => sum + t.amount);
  }
}
