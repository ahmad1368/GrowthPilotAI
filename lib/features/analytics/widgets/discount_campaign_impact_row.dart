import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/discount_campaign_impact.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One campaign's baseline-vs-promotional-window impact row (Issue #362).
class DiscountCampaignImpactRow extends StatelessWidget {
  final DiscountCampaignImpact result;

  const DiscountCampaignImpactRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(result.name, overflow: TextOverflow.ellipsis)),
          Text('${result.discountPercent.toStringAsFixed(0)}%',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(result.campaignRevenue),
              style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Text(
            CurrencyFormat.cad(result.netProfitImpact),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: result.isProfitable ? scheme.primary : scheme.error),
          ),
        ],
      ),
    );
  }
}
