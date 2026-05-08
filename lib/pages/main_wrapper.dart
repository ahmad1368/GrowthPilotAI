import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/utils/workflow/scanner_workflow.dart';
import 'package:growth_pilot_ai/widgets/home_bottom_nav.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  // متد را ساده‌تر کردیم برای تست
  void handleNavigation(int index) {
    debugPrint(
        "🔵 Controller Level: Index $index received"); // اگر این چاپ شود، یعنی اتصال برقرار شد

    if (index == 2) {
      debugPrint("🚀 Triggering Scanner Workflow...");
      ScannerWorkflow.open(Get.context!, (source) {
        debugPrint("Final Source: $source");
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
