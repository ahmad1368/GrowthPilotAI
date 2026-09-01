import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/query_intent.dart';

/// Runs a [QueryIntent] (Issue #199) against local transactions (Issue
/// #261's "Insight Engine" query step) — entirely on-device, matching the
/// issue's own "actual transaction amounts and descriptions stay on the
/// device" privacy requirement. [QueryIntent.category] is matched against
/// [TransactionEntity.description] since transactions don't carry a free-
/// text category string (only a [CategoryEntity] relation).
class FilterTransactionsByIntent {
  static List<TransactionEntity> call(List<TransactionEntity> all, QueryIntent intent) {
    return all.where((t) {
      if (intent.rangeStart != null && t.date.isBefore(intent.rangeStart!)) return false;
      if (intent.rangeEnd != null && t.date.isAfter(intent.rangeEnd!)) return false;
      if (intent.category != null &&
          !t.description.toLowerCase().contains(intent.category!)) {
        return false;
      }
      return true;
    }).toList();
  }
}
