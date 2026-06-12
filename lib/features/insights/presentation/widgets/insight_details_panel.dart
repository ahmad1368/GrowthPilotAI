import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InsightDetailsPanel extends StatelessWidget {
  final int? selectedIndex;
  final IconData? icon;

  const InsightDetailsPanel({
    super.key,
    required this.selectedIndex,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    if (selectedIndex == null) {
      return Center(
        child: Text(
          "لطفاً یک تحلیل را برای مشاهده جزئیات انتخاب کنید.",
          style: ShadTheme.of(context).textTheme.p.copyWith(
                color: fgColor.withValues(alpha: 0.5),
              ),
        ),
      );
    }

    return Container(
      color: isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon ?? Icons.analytics_rounded,
                  color: const Color(0xff2563eb), size: 24),
              const SizedBox(width: 12),
              Text("جزئیات تحلیل شماره ${selectedIndex! + 1}",
                  style: ShadTheme.of(context).textTheme.h3),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "الگوهای مصرفی و داده‌های مالی فاکتور استخراج شده توسط هوش مصنوعی در این بخش به صورت ساختاریافته قابل ارزیابی است.",
            style: ShadTheme.of(context)
                .textTheme
                .p
                .copyWith(color: fgColor.withValues(alpha: 0.8)),
          ),
        ],
      ),
    );
  }
}
