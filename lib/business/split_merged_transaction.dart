import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';

/// Manual "un-merge" (Issue #69): clears the shared group, restoring both
/// records to two independent, unmatched entries.
class SplitMergedTransaction {
  static void call(
    UnifiedTransactionEntity a,
    UnifiedTransactionEntity b,
  ) {
    a.mergeGroupId = null;
    a.matchScore = null;
    b.mergeGroupId = null;
    b.matchScore = null;
  }
}
