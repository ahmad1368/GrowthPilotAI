import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';

class DesktopQualityCard extends StatelessWidget {
  final String statusText;
  const DesktopQualityCard({super.key, required this.statusText});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    return OmniGlassPanel(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // استفاده از آیکون استاندارد و واکنشی به تم پروژه برای حل خطا
          Icon(Icons.document_scanner_rounded, color: iconColor),
          const SizedBox(width: 16),
          AdaptiveText(
            statusText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 24),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
    );
  }
}
