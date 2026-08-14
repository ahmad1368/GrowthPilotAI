import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';
import 'package:growth_pilot_ai/core/models/merchant_commission_summary.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One merchant's aggregated revenue readout and admin override
/// controls (Issue #425, acceptance criteria 3 and 5).
class TieredCommissionSummaryRow extends StatelessWidget {
  final MerchantCommissionSummary summary;
  final CommissionTierBand? overrideBand;
  final void Function(CommissionTierBand) onSetOverride;
  final VoidCallback onClearOverride;

  const TieredCommissionSummaryRow({
    super.key,
    required this.summary,
    required this.overrideBand,
    required this.onSetOverride,
    required this.onClearOverride,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Expanded(
          child: Text(
            '${summary.merchantName}: ${summary.transactionCount} txns — '
            '\$${summary.totalCommission.toStringAsFixed(2)} commission — '
            '${summary.currentTierBand.name}${overrideBand != null ? ' (overridden)' : ''}',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        for (final band in CommissionTierBand.values)
          ShadButton.ghost(
            onPressed: () => onSetOverride(band),
            child: Text('Force ${band.name}', style: const TextStyle(fontSize: 10)),
          ),
        if (overrideBand != null) ShadButton.ghost(onPressed: onClearOverride, child: const Text('Clear')),
      ]),
    );
  }
}
