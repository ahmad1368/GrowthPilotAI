import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/campaign_constraint_snapshot.dart';

/// Per-cap consumption percentages line (Issue #409, acceptance
/// criterion "visibility into consumption percentages") — split out of
/// [AdConstraintRow] to stay under the file line cap.
class AdConstraintConsumptionText extends StatelessWidget {
  final CampaignConstraintSnapshot snapshot;

  const AdConstraintConsumptionText({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time ${(snapshot.timePercent * 100).round()}% · '
      'Impressions ${(snapshot.impressionPercent * 100).round()}% · '
      'Clicks ${(snapshot.clickPercent * 100).round()}%',
      style: const TextStyle(fontSize: 12),
    );
  }
}
