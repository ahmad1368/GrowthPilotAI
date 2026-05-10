import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'omni_glass_panel.dart';
import 'adaptive_text.dart';

class OmniButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool isPrimary;
  final bool isLoading;
  final double? width;
  final bool iconOnRight; // برای کنترل جهت آیکون در متون فارسی/انگلیسی

  const OmniButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.isPrimary = false,
    this.isLoading = false,
    this.width,
    this.iconOnRight = false, // پیش‌فرض سمت چپ (استاندارد)
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    // تعیین رنگ پس‌زمینه بر اساس نوع دکمه و تم
    Color? getBackgroundColor() {
      if (!isPrimary) return null;
      return isDark ? Colors.tealAccent : Colors.teal;
    }

    // استایل متن دکمه
    TextStyle getTextStyle() {
      return TextStyle(
        fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
        color: isPrimary ? (isDark ? Colors.black87 : Colors.white) : null,
      );
    }

    return Opacity(
      opacity: onTap == null || isLoading ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: (onTap == null || isLoading) ? null : onTap,
        child: SizedBox(
          width: width,
          child: OmniGlassPanel(
            opacity: isPrimary ? 0.25 : 0.1,
            isInteractive: onTap != null && !isLoading,
            backgroundColor: getBackgroundColor(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: _buildContent(getTextStyle(), isDark),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TextStyle textStyle, bool isDark) {
    if (isLoading) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
        ),
      );
    }

    // ایجاد لیست ویجت‌ها برای Row
    final content = [
      if (icon != null)
        Icon(
          icon,
          size: 18,
          color: textStyle.color ?? (isDark ? Colors.white : Colors.black87),
        ),
      if (icon != null) const SizedBox(width: 8),
      AdaptiveText(label, style: textStyle),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      // اگر iconOnRight راست بود، ترتیب لیست معکوس می‌شود
      children: iconOnRight ? content.reversed.toList() : content,
    );
  }
}