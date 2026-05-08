import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/common/omni_error_dialog.dart';

class OmniLogger {
  static void log({
    required String title,
    required String message,
    OmniMessageType type = OmniMessageType.info,
    String? actionLabel,
    VoidCallback? onAction,
    String? footer,
  }) {
    // ۱. ارسال به کنسول (قابل پاکسازی در انتهای پروژه)
    debugPrint("---------------------------------------");
    debugPrint("DEBUG LOG: [$title] -> $message");
    debugPrint("---------------------------------------");

    // ۲. نمایش در UI با ویجت استاندارد
    Get.dialog(
      OmniErrorDialog(
        title: title,
        message: message,
        type: type,
        actionLabel: actionLabel,
        onAction: onAction,
        footerText: footer ?? "ID: ${DateTime.now().millisecond}",
      ),
      barrierColor: Colors.black.withValues(alpha: 0.7),
    );
  }
}
