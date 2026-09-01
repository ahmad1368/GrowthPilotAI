import 'package:growth_pilot_ai/core/models/adjustment_impact.dart';

/// One-sentence read naming the most recent commission adjustment's
/// estimated profitability impact (Issue #349).
class BuildImpactNarrative {
  static String call(List<AdjustmentImpact> impacts) {
    if (impacts.isEmpty) {
      return 'No commission adjustments logged yet — impact will appear here once one is made.';
    }
    final latest = impacts.first;
    final direction = latest.impactPercent >= 0 ? 'grew' : 'declined';
    return '${latest.merchantName}\'s estimated retained earnings $direction '
        '${latest.impactPercent.abs().toStringAsFixed(1)}% after the ${latest.previousRatePercent}% '
        '→ ${latest.newRatePercent}% commission change.';
  }
}
