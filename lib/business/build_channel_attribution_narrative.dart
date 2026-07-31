import 'package:growth_pilot_ai/core/models/channel_attribution_summary.dart';

/// One-sentence read naming the best and worst performing marketing
/// channel by ROI (Issue #395).
class BuildChannelAttributionNarrative {
  static String call(List<ChannelAttributionSummary> results) {
    if (results.isEmpty) {
      return 'No ad campaigns logged yet — add one to start tracking channel attribution.';
    }
    if (results.length == 1) {
      final only = results.first;
      return '${only.channel.name} drove ${only.totalNewCustomers} new customers '
          'at ${(only.roi * 100).toStringAsFixed(0)}% ROI.';
    }
    final best = results.first;
    final worst = results.last;
    return '${best.channel.name} is your top channel at ${(best.roi * 100).toStringAsFixed(0)}% ROI — '
        '${worst.channel.name} lags at ${(worst.roi * 100).toStringAsFixed(0)}%.';
  }
}
