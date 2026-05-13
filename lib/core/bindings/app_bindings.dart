import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_service.dart';
import '../../services/connectivity_service.dart';
import '../../services/environment_service.dart';
import '../../services/scanner/scanner_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // سرویس‌های زیرساختی
    Get.lazyPut(() => EnvironmentService(), fenix: true);
    Get.lazyPut(() => ConnectivityService(), fenix: true);

    // سرویس‌های پردازشی (که قبلاً با هم ساختیم)
    Get.lazyPut(() => OCRService(), fenix: true);
    Get.lazyPut(() => ScannerService(), fenix: true);
  }
}
