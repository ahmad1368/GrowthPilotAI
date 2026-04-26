import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double blur;
  final double borderRadius;
  final EdgeInsetsGeometry? margin; // ۱. اضافه کردن متغیر مارجین
  final EdgeInsetsGeometry? padding;

  const GlassCard({
    super.key,
    required this.child,
    this.opacity = 0.1,
    this.blur = 15.0,
    this.borderRadius = 20.0,
    this.margin, // ۲. اضافه کردن به سازنده
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin, // ۳. استفاده از مارجین در کانتینر اصلی
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}