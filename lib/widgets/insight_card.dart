import 'package:flutter/material.dart';
import 'omni_glass_container.dart';
import 'adaptive_text.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String description;
  final String efficiency;
  final IconData icon;

  const InsightCard({
    super.key,
    required this.title,
    required this.description,
    required this.efficiency,
    this.icon = Icons.auto_awesome,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 180,
        child: OmniGlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdaptiveText(title, fontSize: 18, fontWeight: FontWeight.bold),
                  Icon(icon, color: Colors.amber, size: 20),
                ],
              ),
              const Spacer(),
              AdaptiveText(description),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(Icons.bolt, color: Colors.cyanAccent, size: 16),
                  const SizedBox(width: 5),
                  AdaptiveText(efficiency, fontSize: 12),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}