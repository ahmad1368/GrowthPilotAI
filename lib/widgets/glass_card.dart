// lib/widgets/glass_card.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double? opacity; // تغییر به double اختیاری
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const GlassCard({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.opacity, // حالا اختیاری است
    this.borderRadius = 16.0,
    this.padding,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // منطق اولویت‌بندی: 
    // ۱. اگر کاربر مقداری پاس داده بود، همان را استفاده کن.
    // ۲. در غیر این صورت، بر اساس تم (0.05 برای دارک، 0.1 برای لایت) تصمیم بگیر.
    final double effectiveAlpha = opacity ?? (isDark ? 0.05 : 0.1);

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: effectiveAlpha),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}