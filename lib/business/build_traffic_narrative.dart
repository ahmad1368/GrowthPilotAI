import 'package:growth_pilot_ai/business/traffic_bucket_label.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';
import 'package:growth_pilot_ai/core/models/traffic_point.dart';

/// One-sentence, rule-based staffing prompt for the peak traffic bucket
/// (Issue #365) — not the issue's literal ML-correlated staffing model,
/// since this app only has transaction timestamps, not real queue/
/// check-in telemetry.
class BuildTrafficNarrative {
  static String call(List<TrafficPoint> points, TrafficView view) {
    if (points.every((p) => p.count == 0)) {
      return 'Not enough transaction history yet to spot a traffic pattern.';
    }
    final peak =
        points.firstWhere((p) => p.isPeak, orElse: () => points.first);
    final label = TrafficBucketLabel.call(peak.bucket, view);
    final unit = view == TrafficView.byHour ? 'hour' : 'day';
    return '$label is historically your busiest $unit — staff up around then.';
  }
}
