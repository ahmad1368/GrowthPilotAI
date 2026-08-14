import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/fix_account_connection.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/linked_account_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/interfaces/bank_link_service.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Imperative actions for the Connected Accounts screen (Issue #68):
/// pull-to-refresh, per-account sync toggle, and Plaid re-auth.
mixin ConnectedAccountsActions on GetxController {
  RxList<LinkedAccountEntity> get accounts;
  RxBool get isLoading;
  RxnString get busyAccountId;
  LinkedAccountRepository get repo;

  void reload() => accounts.assignAll(repo.getAll());

  Future<void> pullToRefresh() async {
    isLoading.value = true;
    reload();
    OmniLogger.info('Connected Accounts: refreshed ${accounts.length} accounts.');
    isLoading.value = false;
  }

  void toggleActive(String accountId, bool value) {
    final entity = accounts.firstWhereOrNull((a) => a.accountId == accountId);
    if (entity == null) return;
    entity.isActive = value;
    repo.upsert(entity);
    OmniLogger.info('Connected Accounts: $accountId active=$value.');
    reload();
  }

  Future<void> fixConnection(String accountId) async {
    busyAccountId.value = accountId;
    final entity = accounts.firstWhereOrNull((a) => a.accountId == accountId);
    final fixer = FixAccountConnection(DependencyInjection.get<BankLinkService>());
    if (entity != null && await fixer.call()) {
      entity.needsReauth = false;
      repo.upsert(entity);
    }
    busyAccountId.value = null;
    reload();
  }
}
