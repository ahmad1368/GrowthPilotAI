import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/utils/workflow/scanner_workflow.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/home_bottom_nav.dart';

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
                  const Center(child: AdaptiveText("Home")),
                  const Center(child: AdaptiveText("Insights")),
                  const SizedBox.shrink(),
                  const Center(child: AdaptiveText("Profile")),
                  const Center(child: AdaptiveText("Settings")),
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
