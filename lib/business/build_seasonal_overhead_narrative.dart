import 'package:growth_pilot_ai/core/models/seasonal_overhead_point.dart';

/// One-sentence, rule-based budgeting prompt for the peak overhead month
/// (Issue #386) — not the issue's literal energy-efficiency recommendation
/// engine, since no equipment/consumption-sensor data exists in this repo.
class BuildSeasonalOverheadNarrative {
  static String call(List<SeasonalOverheadPoint> points) {
    final hasHistory = points.any((p) => p.averageExpense > 0);
    if (!hasHistory) {
      return 'Not enough expense history yet to spot a seasonal overhead pattern.';
    }
    final peak = points.firstWhere((p) => p.isPeak, orElse: () => points.first);
    final label = SeasonalOverheadPoint.monthLabels[peak.month - 1];
    return '$label is historically your highest-overhead month — budget '
        'ahead for utility and maintenance costs.';
  }
}
