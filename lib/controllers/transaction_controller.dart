import 'package:get/get.dart';
import '../core/data/repositories/transaction_repository.dart';
import '../core/data/entities/transaction_entity.dart';
import '../main.dart'; // برای دسترسی به نمونه سراسری objectbox

class TransactionController extends GetxController {
  // ۱. لیست مشاهده‌گر (Observable) که UI به تغییرات آن واکنش نشان می‌دهد
  var filteredTransactions = <TransactionEntity>[].obs;

  // ۲. تعریف ریپازیتوری
  late TransactionRepository _repository;

  @override
  void onInit() {
    super.onInit();

    // مقداردهی اولیه ریپازیتوری با استفاده از باکس تراکنش‌ها
    _repository =
        TransactionRepository(objectbox.store.box<TransactionEntity>());

    // ۳. ایجاد داده تستی در صورت خالی بودن دیتابیس (برای تست Issue #16)
    _seedTestData();
  }

  /// ایجاد داده‌های اولیه برای اینکه دکمه فیلتر نتیجه‌ای داشته باشد
  void _seedTestData() {
    final transactionBox = objectbox.store.box<TransactionEntity>();

    if (transactionBox.isEmpty()) {
      final now = DateTime.now();

      final testItems = [
        TransactionEntity(
          description: "خرید اشتراک Azure (تستی)",
          amount: 45.0,
          date: now, // استفاده از DateTime طبق Entity شما
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

  /// متد اصلی برای بارگذاری و فیلتر تراکنش‌های ۳۰ روز گذشته
  void loadLastMonthData() {
    final now = DateTime.now();
    final lastMonth = now.subtract(const Duration(days: 30));

    // فراخوانی متد ریپازیتوری با اشیاء DateTime
    final results = _repository.getByDateRange(lastMonth, now);

    // به‌روزرسانی لیست و اطلاع‌رسانی به UI (ویجت‌های Obx)
    filteredTransactions.assignAll(results);

    print("تعداد تراکنش‌های یافت شده در ۳۰ روز اخیر: ${results.length}");
  }

  /// متد جستجوی متنی (آماده‌سازی برای قابلیت‌های هوش مصنوعی)
  void searchTransactions(String query) {
    if (query.isEmpty) {
      loadLastMonthData();
      return;
    }

    final results = _repository.search(query);
    filteredTransactions.assignAll(results);
  }
}
