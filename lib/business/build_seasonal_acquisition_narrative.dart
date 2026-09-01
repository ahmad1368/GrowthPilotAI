import 'package:growth_pilot_ai/core/models/seasonal_acquisition_impact.dart';

/// One-sentence read on which seasonal window pulls in the most new
/// buyers, and how well it retains them (Issue #382).
class BuildSeasonalAcquisitionNarrative {
  static String call(List<SeasonalAcquisitionImpact> impacts) {
    if (impacts.isEmpty) {
      return 'Not enough purchase history yet to evaluate seasonal acquisition.';
    }
    final top = impacts.first;
    final pct = (top.retentionRate * 100).toStringAsFixed(0);
    return '${top.holidayName} acquired ${top.newCustomersAcquired} new buyers, '
        '$pct% of whom came back again — your strongest seasonal acquisition window.';
  }
}
