import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/image_source_sheet.dart';

class ScannerWorkflow {
  static void open(BuildContext context, Function(ImageSource) onAction) {
    debugPrint("🚀 باز کردن منوی اصلی اسکنر...");

    Get.bottomSheet(
      // فراخوانی ویجت اصلی منوی اسکن
      ImageSourceSheet(onSourceSelected: (source) {
        Get.back(); // بستن منو بعد از انتخاب
        onAction(source); // فرستادن منبع انتخاب شده به مرحله بعد
      }),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}
