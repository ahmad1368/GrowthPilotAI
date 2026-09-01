import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_group_discount_rate.dart';
import 'package:growth_pilot_ai/business/compute_group_purchase_progress.dart';
import 'package:growth_pilot_ai/business/is_group_purchase_expired.dart';
import 'package:growth_pilot_ai/business/split_group_purchase_payment.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/core/enum/group_purchase_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_contribution_input.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_contribution_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Status-specific action area for one campaign (Issue #414) — split
/// out of [GroupPurchaseRow] to stay under the file line cap.
class GroupPurchaseRowActions extends StatelessWidget {
  final GroupPurchaseEntity purchase;
  final List<GroupPurchaseContributionEntity> contributions;
  final void Function(String merchantName, int quantity) onContribute;
  final VoidCallback onFinalize;

  const GroupPurchaseRowActions({
    super.key,
    required this.purchase,
    required this.contributions,
    required this.onContribute,
    required this.onFinalize,
  });

  @override
  Widget build(BuildContext context) {
    final progress = ComputeGroupPurchaseProgress.call(purchase, contributions);
    if (purchase.status == GroupPurchaseStatus.finalized) {
      final rate = ComputeGroupDiscountRate.call(progress.totalQuantity, purchase.minQuantityThreshold);
      final owed = SplitGroupPurchasePayment.call(contributions, purchase.unitPrice, rate);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final c in contributions)
            GroupContributionRow(contribution: c, owedAmount: owed[c.merchantName]),
        ],
      );
    }
    if (IsGroupPurchaseExpired.call(purchase, DateTime.now())) {
      return const Text('Expired — threshold not met', style: TextStyle(fontSize: 12));
    }
    return Column(children: [
      GroupContributionInput(onSubmit: onContribute),
      for (final c in contributions) GroupContributionRow(contribution: c),
      if (progress.thresholdMet)
        ShadButton.ghost(onPressed: onFinalize, child: const Text('Finalize Campaign')),
    ]);
  }
}
