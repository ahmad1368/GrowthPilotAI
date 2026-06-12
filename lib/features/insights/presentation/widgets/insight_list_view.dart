import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/insight_model.dart';
import 'package:growth_pilot_ai/features/insights/presentation/widgets/insight_mobile_sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/widgets/insight/insight_list_item.dart';

class InsightListView extends StatelessWidget {
  final ScrollController? controller;
  final String? title;
  final IconData? icon;
  final int? selectedIndex;
  final List<InsightModel> insights; // تزریق لیست بجای داده مرده داخلی
  final ValueChanged<int?> onChanged;

  const InsightListView({
    super.key,
    this.controller,
    this.title,
    this.icon,
    required this.selectedIndex,
    required this.insights,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isWide = MediaQuery.of(context).size.width > 600;

    return CustomScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (icon != null)
                  Icon(icon, color: const Color(0xff2563eb), size: 28),
                const SizedBox(width: 12),
                Text(title ?? "", style: theme.textTheme.h3),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => InsightListItem(
                data: insights[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  onChanged(index);
                  if (!isWide) {
                    InsightMobileSheet.show(context, insights[index]);
                  }
                },
              ),
              childCount: insights.length,
            ),
          ),
        ),
      ],
    );
  }
}
