import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/omni_error_dialog.dart';

class OmniLogger {
  /// متد مرکزی برای چاپ در کنسول و نمایش دیالوگ به صورت همزمان
  /// قابلیت انطباق با تم و تنظیم شفافیت
  static void log({
    required String title,
    required String message,
    OmniMessageType type = OmniMessageType.info,
    String? actionLabel,
    VoidCallback? onAction,
    String? footer,
    double opacity = 0.2, // پارامتر انتخابی برای شفافیت پنل
  }) {
    // ۱. چاپ در کنسول با تفکیک بصری
    String emoji = _getEmojiForType(type);
    debugPrint("\n--- 🟢 OMNI LOG START ---");
    debugPrint("$emoji TYPE: ${type.name.toUpperCase()}");
    debugPrint("$emoji TITLE: $title");
    debugPrint("$emoji MESSAGE: $message");
    debugPrint("--- 🔴 OMNI LOG END ---\n");

    // ۲. نمایش دیالوگ واکنش‌گرا (Responsive to Theme)
    Get.dialog(
      OmniErrorDialog(
        title: title,
        message: message,
        type: type,
        actionLabel: actionLabel,
        onAction: onAction,
        footerText: footer ??
            "Log recorded at: ${DateTime.now().hour}:${DateTime.now().minute}",
        opacity: opacity,
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6), // تیرگی پس‌زمینه پشت دیالوگ
      useSafeArea: true,
    );
  }

  static String _getEmojiForType(OmniMessageType type) {
    switch (type) {
      case OmniMessageType.error:
        return "❌";
      case OmniMessageType.warning:
        return "⚠️";
      case OmniMessageType.schedule:
        return "⏳";
      case OmniMessageType.success:
        return "✅";
      default:
        return "ℹ️";
    }
  }
}
