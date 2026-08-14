import 'package:flutter/material.dart';

/// Flat badge showing this recommendation's historical accept-rate
/// confidence (Issue #418, acceptance criterion 4) — no glow/blur,
/// just a foreground-matched fill per the app's flat theme.
class InventoryRecommendationConfidenceBadge extends StatelessWidget {
  final double confidence;

  const InventoryRecommendationConfidenceBadge({super.key, required this.confidence});

  @override
  Widget build(BuildContext context) {
    final color = confidence >= 0.6
        ? Colors.green
        : confidence <= 0.3
            ? Colors.red
            : Colors.blueGrey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text('${(confidence * 100).toStringAsFixed(0)}% confidence',
          style: TextStyle(fontSize: 11, color: color)),
    );
  }
}
