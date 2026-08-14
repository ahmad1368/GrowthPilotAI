import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/auto_match_transactions.dart';
import 'package:growth_pilot_ai/controllers/transaction_match_actions.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/unified_transaction_repository.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Drives the Duplicate Matches screen (Issue #69): seeds demo Plaid +
/// accounting records, auto-merges high-confidence duplicates on load, and
/// exposes them for the list/details UI. Manual split lives in
/// [TransactionMatchActions].
class TransactionMatchController extends GetxController
    with TransactionMatchActions {
  @override
  var records = <UnifiedTransactionEntity>[].obs;

  @override
  late UnifiedTransactionRepository repo;

  @override
  void onInit() {
    super.onInit();
    repo = UnifiedTransactionRepository(Get.find<ObjectBox>().store.box());
    repo.seedIfEmpty();

    final merged = AutoMatchTransactions.call(repo.getAll());
    for (final (bankTx, accountingTx) in merged) {
      repo.upsert(bankTx);
      repo.upsert(accountingTx);
      OmniLogger.info('Duplicate match: ${bankTx.externalId} <-> '
          '${accountingTx.externalId}.');
    }

    reload();
  }
}
