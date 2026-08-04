import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_impact_narrative.dart';
import 'package:growth_pilot_ai/core/models/adjustment_impact.dart';
import 'package:growth_pilot_ai/core/models/monthly_impact_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/impact_analysis_chart.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/impact_analysis_row.dart';

/// Renders the comparative monthly chart, per-change rows, and a
/// summary narrative (Issue #349) — read-only, so exporting it is
/// already covered by the Business Compass canvas's existing PDF/PNG
/// export (Issue #117) once rendered on the dashboard.
class ImpactAnalysisView extends StatelessWidget {
  final List<AdjustmentImpact> impacts;
  final List<MonthlyImpactPoint> monthlyPoints;

  const ImpactAnalysisView({super.key, required this.impacts, required this.monthlyPoints});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (monthlyPoints.isNotEmpty) ImpactAnalysisChart(points: monthlyPoints),
        const SizedBox(height: 8),
        for (final impact in impacts) ImpactAnalysisRow(impact: impact),
        const SizedBox(height: 8),
        Text(BuildImpactNarrative.call(impacts)),
      ],
    );
  }
}
