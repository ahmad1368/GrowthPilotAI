import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/merchant_trust_tier.dart';
import 'package:growth_pilot_ai/core/models/merchant_trust_score.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Displays a merchant's computed trust score and tier inside the
/// admin merchant profile view (Issue #347, acceptance criterion 2).
class TrustScoreBadge extends StatelessWidget {
  final MerchantTrustScore trustScore;

  const TrustScoreBadge({super.key, required this.trustScore});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (trustScore.tier) {
      MerchantTrustTier.gold => scheme.primary,
      MerchantTrustTier.standard => scheme.onSurface,
      MerchantTrustTier.restricted => Colors.red,
    };
    return ShadBadge.outline(
      child: Text('${trustScore.score} · ${trustScore.tier.name}',
          style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }
}
