import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_seasonal_acquisition_narrative.dart';
import 'package:growth_pilot_ai/core/models/seasonal_acquisition_impact.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_acquisition_row.dart';

/// Renders per-holiday acquisition/retention rows and a summary narrative
/// (Issue #382).
class SeasonalAcquisitionView extends StatelessWidget {
  final List<SeasonalAcquisitionImpact> impacts;

  const SeasonalAcquisitionView({super.key, required this.impacts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (impacts.isEmpty)
          const Text('No seasonal acquisition activity yet.')
        else
          for (final impact in impacts) SeasonalAcquisitionRow(impact: impact),
        const SizedBox(height: 8),
        Text(BuildSeasonalAcquisitionNarrative.call(impacts)),
      ],
    );
  }
}
