import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_group_purchase_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a new-campaign button, every campaign card, and a summary
/// narrative (Issue #414). Purely presentational.
class GroupPurchaseView extends StatelessWidget {
  final List<GroupPurchaseEntity> purchases;
  final List<GroupPurchaseContributionEntity> contributions;
  final VoidCallback onCreate;
  final void Function(GroupPurchaseEntity, String, int) onContribute;
  final void Function(GroupPurchaseEntity) onFinalize;

  const GroupPurchaseView({
    super.key,
    required this.purchases,
    required this.contributions,
    required this.onCreate,
    required this.onContribute,
    required this.onFinalize,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ShadButton.outline(
              onPressed: onCreate,
              child: Text('+ Start Group Purchase', style: TextStyle(color: fg))),
        ]),
        for (final purchase in purchases)
          GroupPurchaseRow(
            purchase: purchase,
            contributions: contributions.where((c) => c.groupPurchaseId == purchase.id).toList(),
            onContribute: (name, qty) => onContribute(purchase, name, qty),
            onFinalize: () => onFinalize(purchase),
          ),
        const SizedBox(height: 8),
        Text(BuildGroupPurchaseNarrative.call(purchases)),
      ],
    );
  }
}
