import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/insights/presentation/widgets/pages/insight_page.dart';

class HomeBody extends StatelessWidget {
  final ScrollController controller;

  const HomeBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return InsightPage(
      controller: controller,
      child: ListView(
        controller: controller,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          // هدر اصلی داشبورد با ساختار مسطح و انترپرایز
          Text(
            "داشبورد مدیریتی GrowthPilot",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: fgColor,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "خلاصه وضعیت، رادارهای تجاری و پایپ‌لاین‌های فعال هوش مصنوعی",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: fgColor.withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 24),

          // اینجا در آینده کارت‌های معیارهای مالی، وضعیت اسکنر و خروجی‌های AI مستقر می‌شوند
          // نمونه ویجت مسطح برای تست رندر لایه فرانت‌اند:
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xff18181b) : const Color(0xfff4f4f5),
              borderRadius:
                  BorderRadius.circular(0), // لبه‌های تیز Vercel-Style
              border: Border.all(
                color:
                    isDark ? const Color(0xff27272a) : const Color(0xffe4e4e7),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "وضعیت سیستم",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: fgColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "تمامی سرویس‌های پردازش ابری و محلی در وضعیت پایدار هستند.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: fgColor.withValues(alpha: 0.7),
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
