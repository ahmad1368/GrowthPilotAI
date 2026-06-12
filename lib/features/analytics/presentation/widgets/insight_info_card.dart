import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/insight_text_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InsightInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const InsightInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgCard = isDark ? const Color(0xff18181b) : const Color(0xffffffff);
    final borderColor =
        isDark ? const Color(0xff27272a) : const Color(0xffe4e4e7);

    return ShadCard(
      backgroundColor: bgCard,
      padding: const EdgeInsets.all(16),
      border: Border.all(color: borderColor),
      content: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                InsightTextContent(title: title, value: value, isDark: isDark),
          ),
        ],
      ),
    );
  }
}
