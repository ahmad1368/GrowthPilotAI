import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One logged warranty claim's cost-vs-coverage row (Issue #389).
class WarrantyClaimRow extends StatelessWidget {
  final WarrantyClaimEntity claim;

  const WarrantyClaimRow({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final net = claim.coverageRevenue - claim.claimCost;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(claim.itemName, overflow: TextOverflow.ellipsis)),
          Text('-${CurrencyFormat.cad(claim.claimCost)}',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 8),
          Text(CurrencyFormat.cad(net),
              style: TextStyle(color: net >= 0 ? scheme.primary : scheme.error)),
        ],
      ),
    );
  }
}
