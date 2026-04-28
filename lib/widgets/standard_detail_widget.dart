import 'package:flutter/material.dart';
import '../models/insight_model.dart';
import 'adaptive_text.dart'; // مدل را ایمپورت کنید

class StandardDetailWidget extends StatelessWidget {
  final InsightModel insight; // دریافت مدل به جای متغیرهای تکی
  final ScrollController? scrollController;

  const StandardDetailWidget({
    super.key,
    required this.insight,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20), // فاصله از لبه‌های نوار ابزار بالا و پایین
      decoration: BoxDecoration(
        // استفاده از رنگ‌های تم برای پشتیبانی از Dark Mode
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2), // سایه برای وضوح بیشتر
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // تیتر
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AdaptiveText(
                  insight.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              _buildBadge(insight.efficiency),
            ],
          ),
          const Divider(height: 32),

          // بدنه اسکرول‌شونده
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                const AdaptiveText(
                  "Detailed Analysis",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                AdaptiveText(
                  insight.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 24),
                // در آینده این بخش را با منطق بارگذاری داده از API جایگزین کنید
                insight.description.isEmpty
                    ? const Center(
                        child:
                            CircularProgressIndicator()) // نمایش لودینگ در صورت نبود داده
                    : const Placeholder(
                        fallbackHeight:
                            150), // اینجا را بعداً با MyChartWidget جایگزین کنید
              ],
            ),
          ),

          // پانویس ثابت
          _buildFooter(context),
        ],
      ),
    ));
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.green[50], borderRadius: BorderRadius.circular(20)),
      child: Text(text,
          style: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white),
            child: AdaptiveText(
              "Understand Insight",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
