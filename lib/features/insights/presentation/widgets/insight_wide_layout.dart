import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/insight_model.dart';
import 'package:growth_pilot_ai/features/insights/presentation/widgets/insight_list_view.dart';
import 'insight_details_panel.dart'; // اضافه کردن امپورت پنل جزئیات جهت رفع خطای دوم

class InsightWideLayout extends StatelessWidget {
  final ScrollController? controller;
  final String? title;
  final IconData? icon;
  final int? selectedIndex;
  final List<InsightModel> insights; // ۱. اضافه شدن لیست جهت رفع خطای اول
  final ValueChanged<int?> onChanged;

  const InsightWideLayout({
    super.key,
    required this.controller,
    required this.title,
    required this.icon,
    required this.selectedIndex,
    required this.insights, // تزریق از لایه پیج اصلی
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: InsightListView(
            controller: controller,
            title: title,
            icon: icon,
            selectedIndex: selectedIndex,
            insights: insights, // ۲. پاس دادن پارامتر به لیست ویو
            onChanged: onChanged,
          ),
        ),
        VerticalDivider(
            width: 1, color: const Color(0xff27272a).withValues(alpha: 0.4)),
        Expanded(
          flex: 3,
          child: InsightDetailsPanel(selectedIndex: selectedIndex, icon: icon),
        ),
      ],
    );
  }
}
