import 'package:flutter/material.dart';
import '../../models/insight_model.dart';
import '../omni_glass_panel.dart';

class InsightListItem extends StatelessWidget {
  final InsightModel data;
  final bool isSelected;
  final VoidCallback onTap;

  const InsightListItem({
    super.key,
    required this.data,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                width: 2),
          ),
          child: OmniGlassPanel(
            title: data.title,
            description: data.description,
            leadingIcon: Icons.auto_graph_rounded,
            isInteractive: true,
            opacity: isSelected ? 0.2 : 0.05,
          ),
        ),
      ),
    );
  }
}
