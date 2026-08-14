import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/compass_period.dart';

/// Resolves a [CompassPeriod] into the trailing date window the Business
/// Compass (Issue #84) recomputes its metrics over.
class FilterTransactionsByPeriod {
  static const _windowDays = {
    CompassPeriod.monthly: 30,
    CompassPeriod.quarterly: 90,
    CompassPeriod.annual: 365,
  };

  static List<TransactionEntity> call(
    List<TransactionEntity> transactions,
    CompassPeriod period,
    DateTime now,
  ) {
    final start = now.subtract(Duration(days: _windowDays[period]!));
    return transactions.where((t) => !t.date.isBefore(start)).toList();
  }
}
