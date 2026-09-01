import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/confirm_mapping_usecase.dart';
import 'package:growth_pilot_ai/business/filter_uncategorized_transactions.dart';
import 'package:growth_pilot_ai/business/group_uncategorized_transactions.dart';
import 'package:growth_pilot_ai/business/mapping_confirmation_executor.dart';
import 'package:growth_pilot_ai/core/data/chart_of_accounts_seed.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/mapping_rule_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_mapping_status_repository.dart';
import 'package:growth_pilot_ai/core/error/failure_mapper.dart';
import 'package:growth_pilot_ai/core/models/merchant_mapping_group.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import 'package:growth_pilot_ai/objectbox.g.dart';

/// Drives the Category Mapping screen (Issue #58): loads uncategorized
/// transactions grouped by merchant with a suggested account, and persists
/// the user's confirmed mapping (+ optional auto-map rule).
class CategoryMappingController extends GetxController {
  var groups = <MerchantMappingGroup>[].obs;
  var selectedAccountId = <String, String?>{}.obs;
  var createRule = <String, bool>{}.obs;
  var isLoading = false.obs;
  var confirmingMerchant = RxnString();

  late MappingRuleRepository _ruleRepo;
  late TransactionMappingStatusRepository _statusRepo;
  late MappingConfirmationExecutor _executor;
  late Box<TransactionEntity> _txnBox;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _txnBox = store.box<TransactionEntity>();
    _ruleRepo = MappingRuleRepository(store.box());
    _statusRepo = TransactionMappingStatusRepository(store.box());
    _executor = MappingConfirmationExecutor(_ruleRepo, _statusRepo);
    loadGroups();
  }

  void loadGroups() {
    try {
      isLoading.value = true;
      final uncategorized = FilterUncategorizedTransactions.call(
          _txnBox.getAll(), _statusRepo.confirmedTransactionIds());
      groups.assignAll(GroupUncategorizedTransactions.call(
        transactions: uncategorized,
        rules: _ruleRepo.getAll(),
        chartOfAccounts: ChartOfAccountsSeed.accounts,
      ));
      OmniLogger.info(
          'CategoryMappingController: loaded ${groups.length} merchant groups.');
    } catch (e, stack) {
      final response = FailureMapper.map<void>(e, stack: stack);
      Get.snackbar('خطا', response.message ?? 'خطا در بارگذاری نگاشت‌ها');
    } finally {
      isLoading.value = false;
    }
  }

  void selectAccount(String merchant, String accountId) =>
      selectedAccountId[merchant] = accountId;

  void toggleCreateRule(String merchant, bool value) =>
      createRule[merchant] = value;

  Future<void> confirm(MerchantMappingGroup group, String accountName) async {
    final accountId = selectedAccountId[group.merchantName] ??
        group.mapping.suggestedAccountId;
    if (accountId == null) return;
    try {
      confirmingMerchant.value = group.merchantName;
      _executor.execute(ConfirmMappingUseCase.call(
        group: group,
        selectedAccountId: accountId,
        selectedAccountName: accountName,
        createRule: createRule[group.merchantName] ?? false,
      ));
      groups.removeWhere((g) => g.merchantName == group.merchantName);
      OmniLogger.info(
          'CategoryMappingController: confirmed "${group.merchantName}" -> $accountId (User: Ahmad_Salem_Pour).');
    } catch (e, stack) {
      final response = FailureMapper.map<void>(e, stack: stack);
      Get.snackbar(
          'خطا', response.message ?? 'خطا در تایید نگاشت — دوباره تلاش کنید');
    } finally {
      confirmingMerchant.value = null;
    }
  }
}
