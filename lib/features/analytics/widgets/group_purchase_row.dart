import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_group_purchase_progress.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_progress_bar.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_row_actions.dart';

/// One group-purchase campaign card (Issue #414) — header info, a
/// dynamic progress indicator toward the volume threshold (acceptance
/// criterion 2), and status-specific actions from
/// [GroupPurchaseRowActions].
class GroupPurchaseRow extends StatelessWidget {
  final GroupPurchaseEntity purchase;
  final List<GroupPurchaseContributionEntity> contributions;
  final void Function(String, int) onContribute;
  final VoidCallback onFinalize;

  const GroupPurchaseRow({
    super.key,
    required this.purchase,
    required this.contributions,
    required this.onContribute,
    required this.onFinalize,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final progress = ComputeGroupPurchaseProgress.call(purchase, contributions);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${purchase.itemName} — organized by ${purchase.organizerName}'),
          Text(
              '${progress.totalQuantity}/${purchase.minQuantityThreshold} units '
              '(\$${purchase.unitPrice.toStringAsFixed(2)}/unit) — ${purchase.status.name}',
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          GroupPurchaseProgressBar(percent: progress.percent),
          const SizedBox(height: 4),
          GroupPurchaseRowActions(
              purchase: purchase,
              contributions: contributions,
              onContribute: onContribute,
              onFinalize: onFinalize),
        ],
      ),
    );
  }
}
