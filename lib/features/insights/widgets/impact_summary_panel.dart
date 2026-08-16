import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/achievement_badge_tier.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "ImpactDashboard" financial summary (Issue #260) — the "Loss Meter",
/// projected profit, and achievement badge as flat text/icon rows, not the
/// issue's literal glassmorphism/Lottie treatment (no new animation
/// dependency is added; architecture forbids Glassmorphism/BackdropFilter).
class ImpactSummaryPanel extends StatelessWidget {
  final double totalOpportunityLoss;
  final double projectedProfit;
  final AchievementBadgeTier badgeTier;

  const ImpactSummaryPanel({
    super.key,
    required this.totalOpportunityLoss,
    required this.projectedProfit,
    required this.badgeTier,
  });

  String get _badgeLabel => switch (badgeTier) {
        AchievementBadgeTier.none => 'No badge yet',
        AchievementBadgeTier.bronze => 'Bronze',
        AchievementBadgeTier.silver => 'Silver',
        AchievementBadgeTier.gold => 'Gold',
      };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Opportunity cost of pending items: \$${totalOpportunityLoss.toStringAsFixed(0)}',
              style: TextStyle(color: Colors.red.withValues(alpha: 0.85), fontSize: 13)),
          Text('Projected profit if completed: \$${projectedProfit.toStringAsFixed(0)}',
              style: TextStyle(color: colors.foreground, fontSize: 13)),
          Text('Milestone: $_badgeLabel',
              style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
        ],
      ),
    );
  }
}
