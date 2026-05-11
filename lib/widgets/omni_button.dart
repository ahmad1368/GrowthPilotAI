import 'package:flutter/material.dart';
import 'adaptive_text.dart';

class OmniButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final double? width;
  final bool isPrimary;

  const OmniButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.width,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // ۱. تعیین رنگ پس‌زمینه دکمه
    final Color bgColor = isPrimary
        ? Colors.cyanAccent // دکمه اصلی همیشه فیروزه‌ای
        : (isDarkMode
            ? Colors.white.withOpacity(0.08)
            : Colors.black.withOpacity(0.05));

    // ۲. تعیین رنگ محتوا (آیکون و متن) - حل مشکل دیده نشدن
    final Color contentColor = isPrimary
        ? Colors.black // روی پس‌زمینه فیروزه‌ای، متن و آیکون باید مشکی باشند
        : (isDarkMode
            ? Colors.cyanAccent
            : Colors.black87); // در حالت عادی، فیروزه‌ای یا مشکی ملایم

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPrimary
                  ? Colors.cyanAccent.withOpacity(0.5)
                  : (isDarkMode ? Colors.white10 : Colors.black12),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // استفاده از رنگ محتوای محاسبه شده برای آیکون
              Icon(
                icon,
                size: 18,
                color: contentColor,
              ),
              const SizedBox(width: 8),
              // استفاده از AdaptiveText یا Text با رنگ مناسب
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: contentColor,
                    fontSize: 13,
                    fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
