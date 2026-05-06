import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Center(
        // برای متمرکز ماندن در حالت دسکتاپ
        child: OmniGlassPanel(
          // استفاده از عرض داینامیک برای جلوگیری از کشیدگی کارت در تبلت/دسکتاپ
          width: UIHelper.getAdaptiveWidth(context),
          height: 180,
          opacity: 0.1,
          isInteractive: true, // قابلیت تعامل هنگام هاور
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ۱. بخش عنوان و آیکون با استایل جدید
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AdaptiveText(
                      title,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    icon,
                    color: Colors.amberAccent,
                    size: 22,
                  ),
                ],
              ),

              const Spacer(),

              // ۲. بخش توضیحات (بهینه‌شده برای خوانایی)
              AdaptiveText(
                description,
                fontSize: 14,
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  height: 1.4,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),

              const SizedBox(height: 15),

              // ۳. بخش شاخص کارایی (Efficiency) با رنگ‌بندی داینامیک
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.bolt_rounded,
                      color: Colors.cyanAccent,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    AdaptiveText(
                      efficiency,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      style: TextStyle(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
