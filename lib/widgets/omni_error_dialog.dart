import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'omni_glass_panel.dart';

enum OmniMessageType { info, warning, error, schedule, success }

class OmniErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final OmniMessageType type;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? footerText;
  final double opacity; // پارامتر جدید برای شفافیت

  const OmniErrorDialog({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.actionLabel,
    this.onAction,
    this.footerText,
    this.opacity = 0.2, // مقدار پیش‌فرض هماهنگ با سایر ویجت‌ها
  });

  @override
  Widget build(BuildContext context) {
    // تشخیص تم برای رنگ متن‌های عمومی
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black87;
    final subTextColor = isDark ? Colors.white30 : Colors.black38;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: OmniGlassPanel(
          opacity: opacity,
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(color: textColor, fontSize: 14, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                if (footerText != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    footerText!,
                    style: TextStyle(color: subTextColor, fontSize: 11),
                  ),
                ],
                const SizedBox(height: 24),
                _buildButtons(context, isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    IconData icon;
    Color color;

    // انتخاب رنگ بر اساس نوع پیام و تم (برای لایت مد رنگ‌ها کمی تیره‌تر می‌شوند تا خوانا باشند)
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (type) {
      case OmniMessageType.error:
        icon = Icons.error_outline_rounded;
        color = isDark ? Colors.redAccent : Colors.red[700]!;
        break;
      case OmniMessageType.warning:
        icon = Icons.warning_amber_rounded;
        color = isDark ? Colors.orangeAccent : Colors.orange[800]!;
        break;
      case OmniMessageType.schedule:
        icon = Icons.history_toggle_off_rounded;
        color = isDark ? Colors.blueAccent : Colors.blue[700]!;
        break;
      case OmniMessageType.success:
        icon = Icons.check_circle_outline_rounded;
        color = isDark ? Colors.greenAccent : Colors.green[700]!;
        break;
      default:
        icon = Icons.info_outline_rounded;
        color = isDark ? Colors.cyanAccent : Colors.cyan[700]!;
    }

    return Column(
      children: [
        Icon(icon, size: 50, color: color),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            "بستن",
            style: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
          ),
        ),
        if (onAction != null)
          ElevatedButton(
            onPressed: () {
              Get.back();
              onAction!();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.15),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              actionLabel ?? "تایید",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
