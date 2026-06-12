import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_result.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DesktopParserCard extends StatelessWidget {
  final FinancialParserResult data;
  const DesktopParserCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);
    final formattedDate = data.extractedDate.toLocal().toString().split(' ')[0];

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.calendar_month_rounded, color: fgColor),
          Text("تاریخ تراکنش: $formattedDate", style: theme.textTheme.p),
          const VerticalDivider(width: 20),
          Icon(Icons.paid_rounded, color: fgColor),
          Text("ارز شناسایی شده: ${data.currency}", style: theme.textTheme.p),
        ],
      ),
    );
  }
}
