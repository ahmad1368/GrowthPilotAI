import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/omni_message_type.dart';
import '../widgets/omni_glass_panel.dart';
import '../widgets/adaptive_text.dart';

class OmniLogger {
  /// متد مرکزی برای چاپ در کنسول و نمایش پنل شیشه‌ای اعلان
  static void log({
    required String title,
    required String message,
    OmniMessageType type = OmniMessageType.info,
    String? actionLabel,
    VoidCallback? onAction,
    String? footer,
    double opacity = 0.14,
  }) {
    // ۱. چاپ در کنسول برای دیباگ
    String emoji = _getEmojiForType(type);
    debugPrint("\n--- 🟢 OMNI LOG START ---");
    debugPrint("$emoji TYPE: ${type.name.toUpperCase()}");
    debugPrint("$emoji TITLE: $title");
    debugPrint("$emoji MESSAGE: $message");
    debugPrint("--- 🔴 OMNI LOG END ---\n");

    // ۲. نمایش پنل شیشه‌ای
    final isDark = Get.isDarkMode;

    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: OmniGlassPanel(
            title: title,
            leadingIcon: _getIconForType(type),
            opacity: opacity,
            backgroundColor: _getColorForType(type, isDark),
            actionButtons: [
              if (actionLabel != null)
                GestureDetector(
                  onTap: () {
                    Get.back();
                    if (onAction != null) onAction();
                  },
                  child: OmniGlassPanel(
                    opacity: 0.15,
                    isInteractive: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: AdaptiveText(
                        actionLabel,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () => Get.back(),
                child: const OmniGlassPanel(
                  opacity: 0.05,
                  isInteractive: true,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: AdaptiveText("بستن"),
                  ),
                ),
              ),
            ],
            footer: Padding(
              padding: const EdgeInsets.only(top: 10),
              // اصلاح: حذف opacity از TextStyle و استفاده از Opacity Widget یا رنگ
              child: Opacity(
                opacity: 0.5,
                child: AdaptiveText(
                  footer ??
                      "زمان ثبت: ${DateTime.now().hour}:${DateTime.now().minute}",
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            child: AdaptiveText(
              message,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
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

  static IconData _getIconForType(OmniMessageType type) {
    switch (type) {
      case OmniMessageType.error:
        return Icons.error_outline_rounded;
      case OmniMessageType.warning:
        return Icons.warning_amber_rounded;
      case OmniMessageType.schedule:
        return Icons.history_rounded;
      case OmniMessageType.success:
        return Icons.check_circle_outline_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  static Color? _getColorForType(OmniMessageType type, bool isDark) {
    switch (type) {
      case OmniMessageType.error:
        return Colors.red.withValues(alpha: isDark ? 0.2 : 0.1);
      case OmniMessageType.success:
        return Colors.green.withValues(alpha: isDark ? 0.2 : 0.1);
      case OmniMessageType.warning:
        return Colors.orange.withValues(alpha: isDark ? 0.2 : 0.1);
      default:
        return null;
    }
  }
}
