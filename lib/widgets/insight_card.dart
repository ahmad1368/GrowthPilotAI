import 'package:flutter/material.dart';
import 'omni_glass_panel.dart'; // استفاده از ویجت واحد جدید
import 'adaptive_text.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String description;
  final String efficiency;
  final IconData icon;

  const InsightCard({
    super.key,
    required this.title,
    required this.description,
    required this.efficiency,
    this.icon = Icons.auto_awesome,
  });

  @override
  Widget build(BuildContext context) {
    // تم رنگی برای هماهنگی با متن‌های پایین کارت
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: OmniGlassPanel(
        height: 180, // ارتفاع ثابت برای نظم در لیست
        opacity: 0.1, // غلظت استاندارد برای کارت‌های لیست
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ۱. بخش عنوان و آیکون
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AdaptiveText(
                  title,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Icon(
                  icon,
                  color: Colors.amber,
                  size: 20,
                ),
              ],
            ),

            const Spacer(),

            // ۲. بخش توضیحات با کنترل تعداد خطوط
            AdaptiveText(
              description,
              fontSize: 14,
              maxLines: 2,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),

            const SizedBox(height: 15),

            // ۳. بخش کارایی (Efficiency) و آیکون رعد
            Row(
              children: [
                const Icon(
                  Icons.bolt,
                  color: Colors.cyanAccent,
                  size: 16,
                ),
                const SizedBox(width: 8),
                AdaptiveText(
                  efficiency,
                  fontSize: 12,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
