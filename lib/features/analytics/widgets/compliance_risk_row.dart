import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/compliance_risk_item.dart';

/// One compliance item's risk row (Issue #392): a warning/expired icon and
/// a days-until-expiry readout, colored by risk tier.
class ComplianceRiskRow extends StatelessWidget {
  final ComplianceRiskItem item;

  const ComplianceRiskRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (item.riskLevel) {
      ComplianceRiskLevel.expired => scheme.error,
      ComplianceRiskLevel.expiringSoon => scheme.error,
      ComplianceRiskLevel.ok => scheme.primary,
    };
    final label = item.daysUntilExpiry < 0
        ? '${-item.daysUntilExpiry}d overdue'
        : '${item.daysUntilExpiry}d left';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                if (item.riskLevel != ComplianceRiskLevel.ok) ...[
                  Icon(Icons.warning_amber_rounded, size: 14, color: color),
                  const SizedBox(width: 4),
                ],
                Flexible(child: Text(item.name, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
