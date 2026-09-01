import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';

/// Groups two matched records under a shared [mergeGroupId] (Issue #69).
/// Neither record's raw data is altered or deleted — merging is purely
/// additive so a later [SplitMergedTransaction] can fully reverse it.
class MergeUnifiedTransactions {
  static String call(
    UnifiedTransactionEntity bankTx,
    UnifiedTransactionEntity accountingTx,
  ) {
    final groupId = '${bankTx.externalId}::${accountingTx.externalId}';
    bankTx.mergeGroupId = groupId;
    accountingTx.mergeGroupId = groupId;
    return groupId;
  }
}
