import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/error/failure_mapper.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart'; // اضافه شدن لاگر
import '../core/data/repositories/transaction_repository.dart';
import '../core/data/entities/transaction_entity.dart';
import '../services/environment_service.dart';

class TransactionController extends GetxController {
  // ۱. لیست‌های مشاهده‌گر
  var filteredTransactions = <TransactionEntity>[].obs;
  var isLoading = false.obs;

  // ۲. تعریف ریپازیتوری
  late TransactionRepository _repository;

  @override
  void onInit() {
    super.onInit();

    try {
      // پیدا کردن اینستنس دیتابیس
      final objectBoxInstance = Get.find<ObjectBox>();

      _repository = TransactionRepository(
        objectBoxInstance.store.box<TransactionEntity>(),
      );

      _seedTestData();
      fetchTransactions();

      OmniLogger.info("TransactionController: Initialized successfully.");
    } catch (e, stack) {
      OmniLogger.error(
        title: "TransactionController Initialization Failed",
        message: e,
        stackTrace: stack,
      );
    }
  }

  /// متد اصلی برای بارگذاری داده‌ها
  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      OmniLogger.info("Fetching transactions...");

      final bool isRemote =
          Get.find<EnvironmentService>().isRemoteEnabled.value;

      if (isRemote) {
        // منطق Cloud (Vancouver Server)
        OmniLogger.warning(
            "Remote fetching is not implemented yet. Pointing to TODO.");
        // TODO: پیاده‌سازی سرویس API
      } else {
        // منطق محلی
        _loadLocalData();
      }
    } catch (e, stack) {
      // تبدیل خطا به ساختار استاندارد و نمایش/لاگ آن
      final response = FailureMapper.map<void>(e, stack: stack);
      Get.snackbar("خطا", response.message ?? "خطا در دریافت اطلاعات");
    } finally {
      isLoading.value = false;
    }
  }

  /// منطق بارگذاری داده‌های محلی
  void _loadLocalData() {
    final now = DateTime.now();
    final lastMonth = now.subtract(const Duration(days: 30));

    final results = _repository.getByDateRange(lastMonth, now);

    filteredTransactions.assignAll(results);
    OmniLogger.info(
        "Local transactions loaded: ${results.length} items found.");
  }

  /// متد جستجوی متنی
  void searchTransactions(String query) {
    if (query.isEmpty) {
      fetchTransactions();
      return;
    }

    final results = _repository.search(query);
    filteredTransactions.assignAll(results);
    OmniLogger.info(
        "Search performed for: '$query'. Results: ${results.length}");
  }

  /// ایجاد داده‌های اولیه (تست)
  void _seedTestData() {
    final objectBoxInstance = Get.find<ObjectBox>();
    final transactionBox = objectBoxInstance.store.box<
        TransactionEntity>(); // استفاده از Getter مستقیم اگر در ObjectBox تعریف شده

    if (transactionBox.isEmpty()) {
      final now = DateTime.now();
      final testItems = [
        TransactionEntity(
          description: "خرید اشتراک Azure (تستی)",
          amount: 45.0,
          date: now,
          dbType: 0,
        ),
        TransactionEntity(
          description: "درآمد پروژه Flutter (تستی)",
          amount: 1200.0,
          date: now.subtract(const Duration(days: 5)),
          dbType: 1,
        ),
      ];

      transactionBox.putMany(testItems);
      OmniLogger.info("Test data seeded into ObjectBox.");
    }
  }
}
