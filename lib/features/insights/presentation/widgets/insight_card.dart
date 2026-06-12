import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    this.icon = Icons.auto_awesome_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? Colors.white : Colors.black;

    return ShadCard(
      width: UIHelper.getAdaptiveWidth(context),
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.all(16),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: ShadTheme.of(context).textTheme.h4.copyWith(
                        color: fgColor,
                      ),
                ),
              ),
              Icon(icon, color: const Color(0xfff59e0b), size: 22),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: ShadTheme.of(context).textTheme.p.copyWith(
                  color: fgColor.withValues(alpha: 0.8),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 16),
          ShadBadge.secondary(
            backgroundColor: const Color(0xff2563eb).withValues(alpha: 0.15),
            text: Text(
              efficiency,
              style: const TextStyle(
                color: Color(0xff2563eb),
                fontWeight: FontWeight.bold,
              ),
            ), // تغییر نام child به text
          ),
        ],
      ),
    );
  }
}
