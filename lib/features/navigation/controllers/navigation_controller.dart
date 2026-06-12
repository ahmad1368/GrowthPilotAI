import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/business/scanner_workflow.dart';

class NavigationController extends GetxController {
  final currentIndex = 0.obs;
  final ScannerWorkflow _scannerWorkflow = ScannerWorkflow();

  void handleNavigation(int index) {
    if (index == 2) {
      _scannerWorkflow.start(Get.context!, (String extractedText) {});
    } else {
      currentIndex.value = index;
    }
  }

  @override
  void onClose() {
    _scannerWorkflow.dispose();
    super.onClose();
  }
}
