import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_warranty_profitability.dart';
import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/warranty_claim_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the net-profitability summary, a quick-add button, and
/// per-claim rows (Issue #389). Purely presentational — the entry list
/// is owned by [WarrantyProfitabilityBody].
class WarrantyProfitabilityView extends StatelessWidget {
  final List<WarrantyClaimEntity> claims;
  final VoidCallback onAddClaim;

  const WarrantyProfitabilityView(
      {super.key, required this.claims, required this.onAddClaim});

  @override
  Widget build(BuildContext context) {
    final summary = ComputeWarrantyProfitability.call(claims);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Net: ${CurrencyFormat.cad(summary.netProfit)}',
                style: TextStyle(
                    color: summary.isProfitable ? scheme.primary : scheme.error),
              ),
            ),
            ShadButton.outline(
              onPressed: onAddClaim,
              child: Text('+ Log Claim', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (claims.isEmpty)
          const Text('No warranty claims logged yet.')
        else
          for (final claim in claims) WarrantyClaimRow(claim: claim),
      ],
    );
  }
}
