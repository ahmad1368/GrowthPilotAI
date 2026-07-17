import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/calculate_combined_balance.dart';
import 'package:growth_pilot_ai/business/group_accounts_by_institution.dart';
import 'package:growth_pilot_ai/controllers/connected_accounts_actions.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/linked_account_repository.dart';
import 'package:growth_pilot_ai/core/models/institution_account_group.dart';

/// Drives the Connected Accounts screen (Issue #68): grouped sub-accounts
/// per institution and a combined-balance header. Imperative actions
/// (refresh/toggle/fix-connection) live in [ConnectedAccountsActions].
class ConnectedAccountsController extends GetxController
    with ConnectedAccountsActions {
  @override
  var accounts = <LinkedAccountEntity>[].obs;
  @override
  var isLoading = false.obs;
  @override
  var busyAccountId = RxnString();

  @override
  late LinkedAccountRepository repo;

  @override
  void onInit() {
    super.onInit();
    repo = LinkedAccountRepository(Get.find<ObjectBox>().store.box());
    repo.seedIfEmpty();
    reload();
  }

  List<InstitutionAccountGroup> get groups =>
      GroupAccountsByInstitution.call(accounts);

  double get combinedBalance => CalculateCombinedBalance.call(accounts);
}
