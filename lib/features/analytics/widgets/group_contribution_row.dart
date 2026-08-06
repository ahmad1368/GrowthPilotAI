import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';

/// One contributor line under a campaign (Issue #414, acceptance
/// criteria 1 and 4) — shows the owed amount once the campaign is
/// finalized and payment has been split.
class GroupContributionRow extends StatelessWidget {
  final GroupPurchaseContributionEntity contribution;
  final double? owedAmount;

  const GroupContributionRow({super.key, required this.contribution, this.owedAmount});

  @override
  Widget build(BuildContext context) {
    final owed = owedAmount;
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 2),
      child: Text(
        owed == null
            ? '${contribution.merchantName}: ${contribution.quantity} unit(s)'
            : '${contribution.merchantName}: ${contribution.quantity} unit(s) — owes \$${owed.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
