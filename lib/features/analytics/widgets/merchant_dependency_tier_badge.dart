import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';
import 'package:growth_pilot_ai/core/enum/merchant_dependency_tier.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Score/tier badge for one merchant's latest dependency evaluation
/// (Issue #424, acceptance criterion 3), mirroring [TrustScoreBadge]'s
/// (#347) tier-to-color mapping.
class MerchantDependencyTierBadge extends StatelessWidget {
  final MerchantDependencyEvaluationEntity? evaluation;

  const MerchantDependencyTierBadge({super.key, required this.evaluation});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final e = evaluation;
    final color = switch (e?.tier) {
      MerchantDependencyTier.highDependency => scheme.primary,
      MerchantDependencyTier.engaged => scheme.onSurface,
      MerchantDependencyTier.standard || null => scheme.onSurface.withValues(alpha: 0.6),
    };
    return ShadBadge.outline(
      child: Text(
        e == null ? 'not evaluated' : '${e.dependencyScore} · ${e.tier.name}',
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
