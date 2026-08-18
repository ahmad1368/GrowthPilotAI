import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Compact KPI readout (Issue #233) — the full "Management Dashboard"
/// is Issue #234's own scope; this is a minimal, reusable summary.
class ProjectMetricsSummaryCard extends StatelessWidget {
  final ProjectMetricsSnapshot snapshot;

  const ProjectMetricsSummaryCard({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Wrap(
        spacing: 20,
        runSpacing: 8,
        children: [
          _stat(colors, 'Requirements', '${snapshot.totalRequirements}'),
          _stat(colors, 'Volatility', '${(snapshot.volatilityRate * 100).round()}%'),
          _stat(colors, 'ROI density', '${(snapshot.roiEstimate * 100).round()}%'),
          _stat(colors, 'Risk score', snapshot.riskScore.toStringAsFixed(0)),
          _stat(colors, 'Complexity', snapshot.complexityIndex.toStringAsFixed(0)),
        ],
      ),
    );
  }

  Widget _stat(ShadColorScheme colors, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
        Text(value,
            style: TextStyle(color: colors.foreground, fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
