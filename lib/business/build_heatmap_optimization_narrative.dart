import 'package:growth_pilot_ai/business/traffic_bucket_label.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';
import 'package:growth_pilot_ai/core/models/traffic_heatmap_cell.dart';

/// One-sentence, rule-based placement prompt for the heatmap's hottest and
/// coldest cells (Issue #354) — not literal Wi-Fi/beacon zone mapping,
/// since this app only has transaction timestamps.
class BuildHeatmapOptimizationNarrative {
  static String call(List<TrafficHeatmapCell> cells) {
    if (cells.every((c) => c.count == 0)) {
      return 'Not enough transaction history yet to spot a traffic pattern.';
    }
    final hottest = cells.firstWhere((c) => c.isPeak);
    final coldest =
        cells.where((c) => c.count > 0).reduce((a, b) => b.count < a.count ? b : a);
    final hotLabel = TrafficBucketLabel.call(hottest.dayOfWeek, TrafficView.byDayOfWeek);
    final coldLabel = TrafficBucketLabel.call(coldest.dayOfWeek, TrafficView.byDayOfWeek);

    return '$hotLabel ${hottest.dayPart.label.toLowerCase()} is your busiest window — '
        'position promotional displays and bestsellers there. '
        '$coldLabel ${coldest.dayPart.label.toLowerCase()} is consistently quiet — '
        'a good window for restocking with less customer disruption.';
  }
}
