import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_merged_transaction_view.dart';
import 'package:growth_pilot_ai/business/split_merged_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/unified_transaction_repository.dart';
import 'package:growth_pilot_ai/core/models/merged_transaction_view.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Read/split actions for [TransactionMatchController] (Issue #69).
mixin TransactionMatchActions on GetxController {
  RxList<UnifiedTransactionEntity> get records;
  UnifiedTransactionRepository get repo;

  void reload() => records.assignAll(repo.getAll());

  UnifiedTransactionEntity? _counterpartOf(UnifiedTransactionEntity tx) =>
      records.firstWhereOrNull(
          (r) => r.mergeGroupId == tx.mergeGroupId && r.externalId != tx.externalId);

  MergedTransactionView? viewFor(UnifiedTransactionEntity tx) {
    if (!tx.isMerged) return null;
    final counterpart = _counterpartOf(tx);
    return counterpart == null
        ? null
        : BuildMergedTransactionView.call(tx, counterpart);
  }

  void split(UnifiedTransactionEntity tx) {
    final counterpart = _counterpartOf(tx);
    if (counterpart == null) return;
    SplitMergedTransaction.call(tx, counterpart);
    repo.upsert(tx);
    repo.upsert(counterpart);
    OmniLogger.info('Split merge: ${tx.externalId} <-> ${counterpart.externalId}.');
    reload();
  }
}
