import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';
import 'package:growth_pilot_ai/core/models/traffic_point.dart';

/// Buckets transactions by hour-of-day or day-of-week and flags the
/// single busiest bucket (Issue #365) — each transaction's timestamp
/// stands in for a customer visit.
class ComputeTrafficDistribution {
  static List<TrafficPoint> call(
    List<TransactionEntity> transactions,
    TrafficView view,
  ) {
    final bucketCount = view == TrafficView.byHour ? 24 : 7;
    final counts = <int, int>{};
    for (final t in transactions) {
      final bucket =
          view == TrafficView.byHour ? t.date.hour : t.date.weekday - 1;
      counts[bucket] = (counts[bucket] ?? 0) + 1;
    }

    final points = [
      for (var b = 0; b < bucketCount; b++)
        TrafficPoint(bucket: b, count: counts[b] ?? 0),
    ];

    final peak = points.reduce((a, b) => b.count > a.count ? b : a);
    if (peak.count <= 0) return points;

    return [
      for (final p in points)
        p.bucket == peak.bucket
            ? TrafficPoint(bucket: p.bucket, count: p.count, isPeak: true)
            : p,
    ];
  }
}
