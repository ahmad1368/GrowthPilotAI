import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/insight_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InsightListItem extends StatelessWidget {
  final InsightModel data;
  final bool isSelected;
  final VoidCallback onTap;

  const InsightListItem({
    super.key,
    required this.data,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    // تعیین رنگ حاشیه بر اساس وضعیت انتخاب (Selection State)
    final borderColor = isSelected
        ? const Color(0xff2563eb)
        : (isDark ? const Color(0xff27272a) : const Color(0xffe4e4e7));

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: ShadCard(
          backgroundColor:
              isDark ? const Color(0xff18181b) : const Color(0xffffffff),
          padding: const EdgeInsets.all(16),
          border: Border.all(color: borderColor, width: 1.5),
          title: Row(
            children: [
              Icon(Icons.auto_graph_rounded, color: fgColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child:
                    Text(data.title, style: ShadTheme.of(context).textTheme.h4),
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              data.description,
              style: ShadTheme.of(context).textTheme.p,
            ),
          ),
        ),
      ),
    );
  }
}
