import 'package:flutter/material.dart';

/// Flat traffic-light pill (Issue #109) — pure presentation, no
/// BackdropFilter/Glassmorphism, matching AssetCustodyStatusBadge's (#157)
/// flat-pill precedent. [IntelligenceStatusBadge] supplies label/colors.
class IntelligenceStatusPill extends StatelessWidget {
  final String label;
  final Color accent;
  final Color foreground;
  final String tooltip;

  const IntelligenceStatusPill({
    super.key,
    required this.label,
    required this.accent,
    required this.foreground,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: accent),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(shape: BoxShape.circle, color: accent),
            ),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: foreground, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
