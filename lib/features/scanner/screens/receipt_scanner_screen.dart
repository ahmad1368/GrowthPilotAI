import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/pages/insight_page.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';

class ReceiptScannerScreen extends StatelessWidget {
  const ReceiptScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InsightPage(
      title: 'اسکن رسید و فاکتور',
      icon: Icons.document_scanner_rounded, // آیکن ملموس برای OCR
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // بخش پیش‌نمایش یا کنترلر
                OmniGlassPanel(
                  opacity: 0.5,
                  child: SizedBox(
                    height: isWide ? 400 : 250,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_rounded,
                            size: 50,
                            color: Colors.white.withValues(alpha: 0.7)),
                        const SizedBox(height: 15),
                        const AdaptiveText(
                            'برای شروع اسکن، دوربین را روی رسید بگیرید',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // بخش نمایش نتایج استخراج شده
                _buildResultPanel(isWide),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultPanel(bool isWide) {
    return OmniGlassPanel(
      opacity: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(Icons.auto_awesome_rounded,
                color: Colors.amber.withValues(alpha: 0.9)),
            const SizedBox(width: 12),
            const Expanded(
              child: AdaptiveText('در انتظار تصویر برای استخراج متنی...'),
            ),
          ],
        ),
      ),
    );
  }
}
