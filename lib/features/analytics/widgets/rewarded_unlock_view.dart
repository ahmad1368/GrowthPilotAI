import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_rewarded_unlock_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/rewarded_unlock_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a trigger button, the read-only unlock log, and a summary
/// narrative (Issue #405). Purely presentational — state is owned by
/// [RewardedUnlockBody].
class RewardedUnlockView extends StatelessWidget {
  final List<RewardedUnlockEntity> unlocks;
  final bool Function(RewardedUnlockEntity) isActive;
  final VoidCallback onTrigger;

  const RewardedUnlockView({
    super.key,
    required this.unlocks,
    required this.isActive,
    required this.onTrigger,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onTrigger,
              child: Text('+ Simulate Rewarded Unlock', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final unlock in unlocks)
          RewardedUnlockRow(unlock: unlock, isActive: isActive(unlock)),
        const SizedBox(height: 8),
        Text(BuildRewardedUnlockNarrative.call(unlocks)),
      ],
    );
  }
}
