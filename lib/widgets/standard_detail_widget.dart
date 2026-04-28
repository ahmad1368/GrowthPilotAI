import 'package:flutter/material.dart';
import '../models/insight_model.dart'; // مدل را ایمپورت کنید

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // گرد کردن تمام گوشه‌ها
        border: Border.all(
            color: Colors.blueAccent.withOpacity(0.5),
            width: 2), // ایجاد Border واضح
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
              Text(insight.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              _buildBadge(insight.efficiency),
            ],
          ),
          const Divider(height: 32),

          // بدنه اسکرول‌شونده
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                const Text("Detailed Analysis",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(insight.description,
                    style: const TextStyle(color: Colors.black54)),
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
            child: const Text("Understand Insight"),
          ),
        ),
      ],
    );
  }
}
