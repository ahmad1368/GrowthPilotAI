import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';

class ClassificationStatusPanel extends StatelessWidget {
  final bool isChecking;
  const ClassificationStatusPanel({super.key, required this.isChecking});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!isChecking) return const SizedBox.shrink();

    return OmniGlassPanel(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
              color: isDark ? Colors.white : Colors.black),
          const SizedBox(width: 16),
          AdaptiveText('Checking image quality...',
              style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        ],
      ),
    );
  }
}
