import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Reliability Badge" (Issue #125 UI Integration AC) — flat pill, not
/// the issue's literal Glassmorphism "Verified shimmer" (architecture
/// forbids Glassmorphism/BackdropFilter). Not yet wired into a business
/// profile screen — none exists in this app yet.
class ReliabilityBadge extends StatelessWidget {
  final double trustScore;
  final bool isVerified;

  const ReliabilityBadge({super.key, required this.trustScore, required this.isVerified});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: colors.muted, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.star_rounded, size: 14, color: colors.primary),
        const SizedBox(width: 4),
        Text(trustScore.toStringAsFixed(1), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        if (isVerified) ...[
          const SizedBox(width: 4),
          Icon(Icons.verified, size: 14, color: colors.primary),
        ],
      ]),
    );
  }
}
