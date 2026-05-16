import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';

class MobileQualityCard extends StatelessWidget {
  final String statusText;
  const MobileQualityCard({super.key, required this.statusText});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    return OmniGlassPanel(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.center_focus_strong_rounded, color: iconColor, size: 28),
          const SizedBox(height: 12),
          AdaptiveText(statusText),
          const SizedBox(height: 12),
          LinearProgressIndicator(
              backgroundColor: iconColor.withValues(alpha: 0.1)),
        ],
      ),
    );
  }
}
