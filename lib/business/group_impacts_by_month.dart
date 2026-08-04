import 'package:growth_pilot_ai/core/models/adjustment_impact.dart';
import 'package:growth_pilot_ai/core/models/monthly_impact_point.dart';

/// Buckets adjustment impacts into calendar-month averages (Issue #349,
/// acceptance criterion 2), oldest month first for charting.
class GroupImpactsByMonth {
  static List<MonthlyImpactPoint> call(List<AdjustmentImpact> impacts) {
    final byMonth = <String, List<double>>{};
    for (final impact in impacts) {
      final label =
          '${impact.timestamp.year}-${impact.timestamp.month.toString().padLeft(2, '0')}';
      (byMonth[label] ??= []).add(impact.impactPercent);
    }

    final labels = byMonth.keys.toList()..sort();
    return [
      for (final label in labels)
        MonthlyImpactPoint(
          monthLabel: label,
          averageImpactPercent: double.parse(
              (byMonth[label]!.reduce((a, b) => a + b) / byMonth[label]!.length)
                  .toStringAsFixed(2)),
          changeCount: byMonth[label]!.length,
        ),
    ];
  }
}
