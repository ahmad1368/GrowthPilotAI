import 'package:growth_pilot_ai/core/models/seasonal_demand_point.dart';

/// One-sentence, rule-based staffing/inventory prompt for the peak season
/// (Issue #352) — not the issue's literal ML-driven recommendation engine,
/// since no model or weather/event data exists in this repo.
class BuildSeasonalDemandNarrative {
  static String call(List<SeasonalDemandPoint> points) {
    final hasHistory = points.any((p) => p.averageRevenue > 0);
    if (!hasHistory) {
      return 'Not enough transaction history yet to spot a seasonal pattern.';
    }
    final peak = points.firstWhere((p) => p.isPeak, orElse: () => points.first);
    final label = SeasonalDemandPoint.monthLabels[peak.month - 1];
    return '$label is historically your strongest month — plan inventory '
        'and staffing ahead of it.';
  }
}
