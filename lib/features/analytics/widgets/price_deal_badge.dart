import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/price_deal_tier.dart';

/// Flat, color-coded badge highlighting a great deal or flagging an
/// overpriced listing (Issue #416, acceptance criterion 3) — no
/// glow/blur, just a foreground-matched fill per the app's flat theme.
class PriceDealBadge extends StatelessWidget {
  final PriceDealTier tier;

  const PriceDealBadge({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (tier) {
      PriceDealTier.greatDeal => ('Great Deal', Colors.green),
      PriceDealTier.overpriced => ('Overpriced', Colors.red),
      PriceDealTier.fairPrice => ('Fair Price', Colors.blueGrey),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, color: color)),
    );
  }
}
