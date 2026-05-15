import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_result.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';

class MobileParserCard extends StatelessWidget {
  final FinancialParserResult data;
  const MobileParserCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    return OmniGlassPanel(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit_calendar_rounded, color: iconColor),
            title: AdaptiveText(
                "تاریخ: ${data.extractedDate.toLocal().toString().split(' ')[0]}"),
          ),
          ListTile(
            leading: Icon(Icons.currency_exchange_rounded, color: iconColor),
            title: AdaptiveText("ارز مبنا: ${data.currency}"),
          ),
        ],
      ),
    );
  }
}
