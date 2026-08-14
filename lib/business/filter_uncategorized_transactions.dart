import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

/// Excludes soft-deleted and already-confirmed transactions from the
/// Category Mapping screen's worklist (Issue #58).
class FilterUncategorizedTransactions {
  static List<TransactionEntity> call(
    List<TransactionEntity> all,
    Set<int> confirmedTransactionIds,
  ) {
    return all
        .where((t) => !t.isDeleted && !confirmedTransactionIds.contains(t.id))
        .toList();
  }
}
