import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/merchant_partnership_value.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One logged partnership's collaborative value row (Issue #393).
class MerchantPartnershipRow extends StatelessWidget {
  final MerchantPartnershipValue result;

  const MerchantPartnershipRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
                  '${result.partnerBusinessName} (${result.partnerCategory})',
                  overflow: TextOverflow.ellipsis)),
          Text('${result.synergyLevel.name} synergy',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(result.jointCampaignRevenue),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: result.isHighValue ? scheme.primary : scheme.onSurface)),
        ],
      ),
    );
  }
}
