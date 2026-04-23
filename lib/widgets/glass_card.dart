// lib/widgets/glass_card.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // استفاده از رنگ سطحی تم با شفافیت برای ایجاد حالت شیشه‌ای
            // مقدار شفافیت را بین 0.0 تا 1.0 در alpha وارد کنید
color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha:0.1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}