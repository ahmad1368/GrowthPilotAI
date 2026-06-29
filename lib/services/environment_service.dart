import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';

class EnvironmentService extends GetxService {
  // به صورت پیش‌فرض در حالت دیباگ روی لوکال (false) و در نسخه نهایی روی ریموت (true) است
  final isRemoteEnabled = (!kDebugMode).obs;

  /// متدی که در فایل‌های UI صدا زده می‌شود
  void toggleDataSource(bool useRemote) {
    isRemoteEnabled.value = useRemote;

    // ۱. رفرش کردن تراکنش‌ها به محض تغییر منبع داده
    if (Get.isRegistered<TransactionController>()) {
      Get.find<TransactionController>().fetchTransactions();
    }

    // ۲. نمایش اطلاع‌رسانی به کاربر/توسعه‌دهنده
    Get.snackbar(
      "Data Source Updated",
      useRemote ? "Switched to Cloud API" : "Switched to Local ObjectBox",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withValues(alpha: 0.7),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(15),
    );
  }
}
