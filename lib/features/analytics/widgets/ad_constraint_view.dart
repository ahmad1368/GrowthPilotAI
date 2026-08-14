import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/campaign_constraint_snapshot.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a configure button and every constrained campaign's row
/// (Issue #409). Purely presentational.
class AdConstraintView extends StatelessWidget {
  final List<CampaignConstraintSnapshot> snapshots;
  final VoidCallback onConfigure;
  final void Function(int) onSimulateImpression;
  final void Function(int) onSimulateClick;

  const AdConstraintView({
    super.key,
    required this.snapshots,
    required this.onConfigure,
    required this.onSimulateImpression,
    required this.onSimulateClick,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onConfigure,
              child: Text('+ Configure Limits', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (snapshots.isEmpty) const Text('No constrained campaigns yet.'),
        for (final snapshot in snapshots)
          AdConstraintRow(
            snapshot: snapshot,
            onSimulateImpression: () => onSimulateImpression(snapshot.request.id),
            onSimulateClick: () => onSimulateClick(snapshot.request.id),
          ),
      ],
    );
  }
}
