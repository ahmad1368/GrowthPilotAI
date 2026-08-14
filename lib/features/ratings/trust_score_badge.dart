import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/trust_badge.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Trust Glow" AC (Issue #135) — a flat colored border highlight for
/// Elite/Verified-Pro tiers instead of the issue's literal Glassmorphism
/// glow (architecture forbids Glassmorphism/BackdropFilter). Not yet
/// wired into a business profile screen — none exists in this app yet.
class TrustScoreBadge extends StatelessWidget {
  final double score;
  final TrustBadge badge;

  const TrustScoreBadge({super.key, required this.score, required this.badge});

  String get _label => switch (badge) {
        TrustBadge.elite => 'Elite',
        TrustBadge.verifiedPro => 'Verified Pro',
        TrustBadge.standard => 'Standard',
      };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final accent = badge == TrustBadge.standard ? colors.border : colors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: accent, width: badge == TrustBadge.standard ? 1 : 2),
          borderRadius: BorderRadius.circular(20)),
      child: Text('${score.toStringAsFixed(1)} · $_label', style: const TextStyle(fontSize: 12)),
    );
  }
}
