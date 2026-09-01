import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_compliance_risk.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_risk_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the compliance-risk rows + a quick-add button (Issue #392).
/// Purely presentational — [ComplianceRiskBody] owns the item list.
class ComplianceRiskView extends StatelessWidget {
  final List<ComplianceItemEntity> items;
  final VoidCallback onAddItem;

  const ComplianceRiskView({super.key, required this.items, required this.onAddItem});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final risks = ComputeComplianceRisk.call(items, DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('License & permit expiry tracking',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onAddItem,
              child: Text('+ Add Item', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (risks.isEmpty)
          const Text('No compliance items tracked yet.')
        else
          for (final r in risks) ComplianceRiskRow(item: r),
      ],
    );
  }
}
