import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_result.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MobileParserCard extends StatelessWidget {
  final FinancialParserResult data;
  const MobileParserCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);
    final formattedDate = data.extractedDate.toLocal().toString().split(' ')[0];

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.all(8),
      content: Column(
        // تغییر نام child به content
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit_calendar_rounded, color: fgColor),
            title: Text("تاریخ: $formattedDate", style: theme.textTheme.p),
          ),
          ListTile(
            leading: Icon(Icons.currency_exchange_rounded, color: fgColor),
            title: Text("ارز مبنا: ${data.currency}", style: theme.textTheme.p),
          ),
        ],
      ),
    );
  }
}
