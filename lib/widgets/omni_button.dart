import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'omni_glass_panel.dart';
import 'adaptive_text.dart';

class OmniButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isPrimary;
  final double? width;
  final double height;
  final double borderRadius;

  const OmniButton({
    super.key,
    this.label,
    this.icon,
    required this.onTap,
    this.isPrimary = false,
    this.width,
    this.height = 48,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    // تعیین رنگ محتوا بر اساس نوع دکمه و تم
    // اگر Primary باشد، رنگ معکوس پس‌زمینه را می‌گیرد تا خوانا باشد
    final Color? contentColor =
        isPrimary ? (isDark ? Colors.black : Colors.white) : null;

    // تعیین رنگ پس‌زمینه دکمه‌های Primary بر اساس برند پروژه
    final Color? bgColor =
        isPrimary ? (isDark ? Colors.tealAccent.shade700 : Colors.teal) : null;

    return Bounceable(
      onTap: onTap,
      scaleFactor: 0.95, // میزان فشرده شدن دکمه هنگام لمس
      child: OmniGlassPanel(
        width: width,
        height: height,
        borderRadius: borderRadius,
        // شفافیت هوشمند مطابق استاندارد جدید پروژه
        opacity: isDark ? 0.1 : 0.9,
        isInteractive: true,
        backgroundColor: bgColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 20,
                    color:
                        contentColor, // اگر null باشد از تم سراسری main.dart می‌خواند
                  ),
                if (icon != null && label != null) const SizedBox(width: 10),
                if (label != null)
                  AdaptiveText(
                    label!,
                    style: TextStyle(
                      fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                      color: contentColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
