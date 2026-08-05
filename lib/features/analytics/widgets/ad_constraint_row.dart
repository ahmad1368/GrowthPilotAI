import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/campaign_constraint_status.dart';
import 'package:growth_pilot_ai/core/models/campaign_constraint_snapshot.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_consumption_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One constrained campaign row (Issue #409) — status, consumption,
/// alert, and telemetry-simulation controls while still active.
class AdConstraintRow extends StatelessWidget {
  final CampaignConstraintSnapshot snapshot;
  final VoidCallback onSimulateImpression;
  final VoidCallback onSimulateClick;

  const AdConstraintRow({
    super.key,
    required this.snapshot,
    required this.onSimulateImpression,
    required this.onSimulateClick,
  });

  @override
  Widget build(BuildContext context) {
    final active = snapshot.status == CampaignConstraintStatus.active;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text('${snapshot.request.merchantName} — ${snapshot.status.name}')),
              if (active) ...[
                ShadButton.ghost(
                    onPressed: onSimulateImpression, child: const Text('Simulate View')),
                ShadButton.ghost(onPressed: onSimulateClick, child: const Text('Simulate Click')),
              ],
            ],
          ),
          AdConstraintConsumptionText(snapshot: snapshot),
          if (snapshot.alert != null)
            Text(snapshot.alert!,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
