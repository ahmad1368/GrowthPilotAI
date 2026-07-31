import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_channel_attribution_narrative.dart';
import 'package:growth_pilot_ai/core/models/channel_attribution_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/channel_attribution_row.dart';

/// Renders per-channel attribution rows and a summary narrative
/// (Issue #395). Purely presentational — campaigns are logged from the
/// existing Ad Campaign ROI report, this widget only aggregates them.
class ChannelAttributionView extends StatelessWidget {
  final List<ChannelAttributionSummary> results;

  const ChannelAttributionView({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final result in results) ChannelAttributionRow(result: result),
        const SizedBox(height: 8),
        Text(BuildChannelAttributionNarrative.call(results)),
      ],
    );
  }
}
