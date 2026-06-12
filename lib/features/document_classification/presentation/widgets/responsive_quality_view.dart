import 'package:flutter/material.dart';
import 'desktop_quality_card.dart';
import 'mobile_quality_card.dart';

class ResponsiveQualityView extends StatelessWidget {
  final String statusText;
  const ResponsiveQualityView({super.key, required this.statusText});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // استاندارد مانیتورهای عریض B2B برای سوئیچ لایوت
        if (constraints.maxWidth > 600) {
          return DesktopQualityCard(statusText: statusText);
        }
        return MobileQualityCard(statusText: statusText);
      },
    );
  }
}
