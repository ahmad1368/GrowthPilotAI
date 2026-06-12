import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/insights/presentation/widgets/pages/insight_page.dart';
import 'package:growth_pilot_ai/features/scanner/screens/presentation/widgets/presentation/widgets/receipt_scanner_result_panel.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReceiptScannerScreen extends StatelessWidget {
  const ReceiptScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return InsightPage(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 💡 انتقال تیتر و آیکون به بخش فرزند جهت دور زدن محدودیت پارامترهای ناموجود والد
                Row(
                  children: [
                    Icon(Icons.document_scanner_rounded,
                        color: fgColor, size: 24),
                    const SizedBox(width: 8),
                    Text('اسکن رسید و فاکتور', style: theme.textTheme.h3),
                  ],
                ),
                const SizedBox(height: 20),
                ShadCard(
                  backgroundColor: isDark
                      ? const Color(0xff18181b)
                      : const Color(0xffffffff),
                  padding: const EdgeInsets.all(16),
                  content: SizedBox(
                    height: isWide ? 400 : 250,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_rounded,
                            size: 50, color: fgColor),
                        const SizedBox(height: 15),
                        Text(
                          'برای شروع اسکن، دوربین را روی رسید بگیرید',
                          style: theme.textTheme.p
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ReceiptScannerResultPanel(isDark: isDark, theme: theme),
              ],
            ),
          );
        },
      ),
    );
  }
}
