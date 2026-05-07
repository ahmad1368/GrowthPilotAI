import 'package:get/get.dart';
import '../core/data/repositories/transaction_repository.dart';
import '../core/data/entities/transaction_entity.dart';
import '../services/environment_service.dart';
import '../main.dart'; // برای دسترسی به نمونه سراسری objectbox

class TransactionController extends GetxController {
  // ۱. لیست‌های مشاهده‌گر (Observable)
  // از همان نام قبلی پروژه شما (filteredTransactions) استفاده می‌کنیم تا UI خراب نشود
  var filteredTransactions = <TransactionEntity>[].obs;
  var isLoading = false.obs;

  // ۲. تعریف ریپازیتوری
  late TransactionRepository _repository;

  @override
  void onInit() {
    super.onInit();

    // مقداردهی اولیه ریپازیتوری با استفاده از باکس تراکنش‌ها
    _repository =
        TransactionRepository(objectbox.store.box<TransactionEntity>());

    // ایجاد داده تستی در صورت خالی بودن دیتابیس (Issue #16)
    _seedTestData();

    // لود اولیه داده‌ها بر اساس وضعیت سوئیچ دیتابیس
    fetchTransactions();
  }

  /// متد اصلی برای بارگذاری داده‌ها (ترکیب منطق آنلاین و آفلاین)
  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;

      // بررسی وضعیت سوئیچ دیتابیس از سرویس محیطی
      final bool isRemote =
          Get.find<EnvironmentService>().isRemoteEnabled.value;

      if (isRemote) {
        // --- منطق دریافت از وب (API) ---
        // TODO: پس از آماده شدن API، کد زیر را جایگزین کنید
        print("Fetching data from Remote Cloud Database (Vancouver Server)...");
        // مثال: final remoteData = await _apiService.getAll();
        // filteredTransactions.assignAll(remoteData);
      } else {
        // --- منطق دریافت از دیتابیس محلی (ObjectBox) ---
        print("Fetching data from Local ObjectBox...");
        _loadLocalData();
      }
    } catch (e) {
      print("Error fetching transactions: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// منطق بارگذاری داده‌های محلی (کد قبلی شما)
  void _loadLocalData() {
    final now = DateTime.now();
    final lastMonth = now.subtract(const Duration(days: 30));

    // استفاده از ریپازیتوری برای فیلتر ۳۰ روز اخیر
    final results = _repository.getByDateRange(lastMonth, now);

    // به‌روزرسانی لیست
    filteredTransactions.assignAll(results);
    print("تعداد تراکنش‌های محلی یافت شده: ${results.length}");
  }

  /// متد جستجوی متنی (قابلیت قبلی شما)
  void searchTransactions(String query) {
    if (query.isEmpty) {
      fetchTransactions();
      return;
    }

    final results = _repository.search(query);
    filteredTransactions.assignAll(results);
  }

  /// ایجاد داده‌های اولیه (کد قبلی شما)
  void _seedTestData() {
    final transactionBox = objectbox.store.box<TransactionEntity>();

    if (transactionBox.isEmpty()) {
      final now = DateTime.now();
      final testItems = [
        TransactionEntity(
          description: "خرید اشتراک Azure (تستی)",
          amount: 45.0,
          date: now,
          dbType: 0, // Expense
        ),
        TransactionEntity(
          description: "درآمد پروژه Flutter (تستی)",
          amount: 1200.0,
          date: now.subtract(const Duration(days: 5)),
          dbType: 1, // Income
        ),
      ];

      transactionBox.putMany(testItems);
      print("داده‌های تستی با موفقیت به دیتابیس اضافه شدند.");
    }
  }
}
