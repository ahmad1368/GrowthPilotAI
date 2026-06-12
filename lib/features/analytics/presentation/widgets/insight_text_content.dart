import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InsightTextContent extends StatelessWidget {
  final String title;
  final String value;
  final bool isDark;

  const InsightTextContent({
    super.key,
    required this.title,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: ShadTheme.of(context).textTheme.small.copyWith(
                color: fgColor.withValues(alpha: 0.5),
                fontSize: 11,
              ),
        ),
        const SizedBox(height: 2), // این ویجت می‌تواند const باقی بماند
        Text(
          value,
          style: ShadTheme.of(context).textTheme.h4.copyWith(
                color: fgColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
