import 'dart:ui';
import 'package:flutter/material.dart';

class OmniGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? blur; // پارامتر جدید برای تنظیم میزان شیشه‌ای بودن

  const OmniGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 25,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.blur, // مقدار می‌تواند نال باشد
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // محاسبه میزان بلور منطقی اگر کاربر مقداری وارد نکرده باشد
    // در حالت تاریک ۱۵ و در حالت روشن ۱۰ مقدار بهینه‌ای است
    final double effectiveBlur = blur ?? (isDark ? 15.0 : 10.0);

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              // تنظیم هوشمند رنگ پس‌زمینه شیشه
              color: isDark 
                  ? Colors.white.withOpacity(0.08) 
                  : Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: isDark 
                    ? Colors.white.withOpacity(0.1) 
                    : Colors.black.withOpacity(0.1),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}