import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_result.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';

class DesktopParserCard extends StatelessWidget {
  final FinancialParserResult data;
  const DesktopParserCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    return OmniGlassPanel(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.calendar_month_rounded, color: iconColor),
          AdaptiveText(
              "تاریخ تراکنش: ${data.extractedDate.toLocal().toString().split(' ')[0]}"),
          const VerticalDivider(width: 20),
          Icon(Icons.paid_rounded, color: iconColor),
          AdaptiveText("ارز شناسایی شده: ${data.currency}"),
        ],
      ),
    );
  }
}
