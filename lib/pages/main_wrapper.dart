import 'package:get/get.dart';
import 'package:growth_pilot_ai/utils/workflow/scanner_workflow.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  // ۱. ایجاد نمونه از ورک‌فلو جدید (جایگزین متد استاتیک قدیمی)
  final ScannerWorkflow _scannerWorkflow = ScannerWorkflow();

  void handleNavigation(int index) {
    if (index == 2) {
      // استفاده از متد start به جای open
      _scannerWorkflow.start(Get.context!, (String extractedText) {
        // این کالبک وقتی اجرا می‌شود که OCR با موفقیت تمام شده باشد
        // Get.snackbar(
        //   "Success",
        //   "OCR Completed: ${extractedText.length} characters found",
        //   backgroundColor: Colors.cyanAccent.withValues(alpha: 0.1),
        //   colorText: Colors.cyanAccent,
        // );
      });
    } else if (index == 4) {
      // [Issue #821] Was Settings (still reachable via the unchanged
      // top-app-bar gear icon, #794/#800) — now Marketplace, a full
      // pushed route ('/business-compass', where the marketplace report
      // widgets live) rather than tab-swappable body content, same
      // pattern Settings used and Scan (index 2) still uses above.
      Get.toNamed('/business-compass');
    } else {
      currentIndex.value = index;
    }
  }

  @override
  void onClose() {
    // ۲. حتماً منابع را آزاد می‌کنیم (بسیار مهم برای Issue #22)
    _scannerWorkflow.dispose();
    super.onClose();
  }
}
