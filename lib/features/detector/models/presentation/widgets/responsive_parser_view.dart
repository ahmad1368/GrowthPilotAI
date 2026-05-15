import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_result.dart';
import 'package:growth_pilot_ai/features/detector/models/presentation/widgets/desktop_parser_card.dart';
import 'package:growth_pilot_ai/features/detector/models/presentation/widgets/mobile_parser_card.dart';

class ResponsiveParserView extends StatelessWidget {
  final FinancialParserResult data;
  const ResponsiveParserView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // مانیتورهای بزرگ، تبلت‌ها و تحت وب عریض
        if (constraints.maxWidth > 650) {
          return DesktopParserCard(data: data);
        }
        // مانیتورهای کوچک و موبایل‌های عمودی استاندارد
        return MobileParserCard(data: data);
      },
    );
  }
}
