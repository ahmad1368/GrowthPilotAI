import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InsightHeader extends StatelessWidget {
  const InsightHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Smart Analysis",
              style: ShadTheme.of(context).textTheme.h2.copyWith(
                    color: fgColor,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              "Real-time financial insights based on your spending.",
              style: ShadTheme.of(context).textTheme.p.copyWith(
                    color: fgColor.withValues(alpha: 0.6),
                  ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
