import 'package:growth_pilot_ai/core/data/entities/traffic_steering_directive_entity.dart';
import 'package:growth_pilot_ai/core/models/traffic_steering_summary.dart';

/// Aggregates logged traffic-steering directives into a ranked list with
/// each directive's share of total redirects (Issue #334) — this app has
/// no backend redirect service, so steering actions and their volumes are
/// logged manually instead.
class ComputeTrafficSteeringSummary {
  static List<TrafficSteeringSummary> call(
      List<TrafficSteeringDirectiveEntity> directives) {
    final totalRedirects =
        directives.fold<int>(0, (sum, d) => sum + d.redirectCount);

    final results = directives.map((d) {
      final share = totalRedirects == 0
          ? 0.0
          : double.parse(
              (d.redirectCount / totalRedirects * 100).toStringAsFixed(2));

      return TrafficSteeringSummary(
        targetName: d.targetName,
        destinationLabel: d.destinationLabel,
        redirectCount: d.redirectCount,
        deviationSharePercent: share,
        createdAt: d.createdAt,
      );
    }).toList();

    results.sort((a, b) => b.redirectCount.compareTo(a.redirectCount));
    return results;
  }
}
