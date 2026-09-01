import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/omni_button.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';

class OmniAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final List<OmniButton> actions;

  const OmniAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        constraints: BoxConstraints(
            maxWidth: screenWidth > 600 ? 500 : screenWidth * 0.9),
        padding: const EdgeInsets.all(16),
        child: OmniGlassPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: iconColor),
              const SizedBox(height: 12),
              AdaptiveText(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              AdaptiveText(content,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: actions
                    .map((btn) => Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: btn)))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
