import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/services/scanner/scanner_service.dart';
import 'package:growth_pilot_ai/utils/workflow/scanner_workflow.dart';
import 'package:growth_pilot_ai/widgets/home_bottom_nav.dart';
import 'package:image_picker/image_picker.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  // ۱. تعریف سرویس اسکنر (این خط همان تکه گمشده پازل است)
  final ScannerService _scanner = ScannerService();

  void handleNavigation(int index) {
    if (index == 2) {
      ScannerWorkflow.open(Get.context!, (ImageSource source) async {
        debugPrint("📸 Source Received in Controller: $source");

        // ۲. حالا _scanner شناخته شده است و متد اجرا می‌شود
        try {
          final file = await _scanner.pickAndCrop(source, Get.context!);

          if (file != null) {
            debugPrint("✅ تصویر با موفقیت ذخیره شد: ${file.path}");
            Get.snackbar(
              "موفقیت",
              "تصویر آماده پردازش است",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.7),
              colorText: Colors.white,
            );
          } else {
            debugPrint("❌ کاربر عملیات را لغو کرد");
          }
        } catch (e) {
          debugPrint("🔥 خطا در اجرای اسکنر: $e");
          Get.snackbar("خطا", "مشکلی در باز کردن دوربین یا گالری رخ داد");
        }
      });
    } else {
      currentIndex.value = index;
    }
  }
}

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // ایجاد کنترلر
    final controller = Get.put(NavigationController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // صفحات
          Obx(() => IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  const Center(
                      child:
                          Text("Home", style: TextStyle(color: Colors.white))),
                  const Center(
                      child: Text("Insights",
                          style: TextStyle(color: Colors.white))),
                  const SizedBox.shrink(),
                  const Center(
                      child: Text("Profile",
                          style: TextStyle(color: Colors.white))),
                  const Center(
                      child: Text("Settings",
                          style: TextStyle(color: Colors.white))),
                ],
              )),

          // در بخش build فایل main_wrapper.dart
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() => HomeBottomNav(
                  currentIndex: controller.currentIndex.value,
                  // دیگر نیازی به پاس دادن onTap نیست چون خودش Get.find می‌کند
                )),
          ),
        ],
      ),
    );
  }
}
