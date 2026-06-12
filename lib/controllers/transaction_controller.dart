import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/error/failure_mapper.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import '../core/data/repositories/transaction_repository.dart';
import '../core/data/entities/transaction_entity.dart';
import '../services/environment_service.dart';
import '../core/interfaces/i_transaction_controller.dart';
import '_transaction_helper.dart';

class TransactionController extends ITransactionController {
  @override
  var filteredTransactions = <TransactionEntity>[].obs;
  @override
  var isLoading = false.obs;

  late final TransactionRepository _repository;

  @override
  void onInit() {
    super.onInit();
    try {
      final objectBox = Get.find<ObjectBox>();
      _repository =
          TransactionRepository(objectBox.store.box<TransactionEntity>());

      TransactionHelper.seedTestData(objectBox.store.box<TransactionEntity>());
      fetchTransactions();

      OmniLogger.info(
          message: "TransactionController: Initialized successfully.",
          worker: "Ahmad_Salem_Pour");
    } catch (e, stack) {
      OmniLogger.error(
          message: e.toString(),
          serviceName: "TransactionController",
          stackTrace: stack,
          worker: "Ahmad_Salem_Pour");
    }
  }

  @override
  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      OmniLogger.info(
          message: "Fetching transactions...", worker: "Ahmad_Salem_Pour");

      if (Get.find<EnvironmentService>().isRemoteEnabled.value) {
        OmniLogger.warning(
            message: "Remote fetching is TODO. Pointing to local.",
            worker: "Ahmad_Salem_Pour");
      } else {
        final results = _repository.getByDateRange(
            DateTime.now().subtract(const Duration(days: 30)), DateTime.now());
        filteredTransactions.assignAll(results);
        OmniLogger.info(
            message: "Local transactions loaded: ${results.length} items.",
            worker: "Ahmad_Salem_Pour");
      }
    } catch (e, stack) {
      final response = FailureMapper.map<void>(e, stack: stack);
      Get.snackbar("خطا", response.message ?? "خطا در دریافت اطلاعات");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> searchTransactions(String query) async {
    if (query.isEmpty) {
      await fetchTransactions();
      return;
    }
    final results = _repository.search(query);
    filteredTransactions.assignAll(results);
    OmniLogger.info(
        message: "Search for: '$query'. Results: ${results.length}",
        worker: "Ahmad_Salem_Pour");
  }
}
