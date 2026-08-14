import 'dart:math';

import 'package:growth_pilot_ai/business/add_laplace_noise.dart';
import 'package:growth_pilot_ai/core/data/entities/anonymized_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/hotspot_stat.dart';

/// The "Supply-Demand Heatmap" aggregator (Issue #95): filters to
/// listings recorded on/after [since] (mirrors the pipeline's 7-day
/// `$match`), groups by generalized location+category (`$group`), and
/// DP-noises each group's count (AC: "small counts are either rounded or
/// noise-injected as per #91") before sorting by busiest area (`$sort`).
class ComputeHotspotStats {
  static List<HotspotStat> call(
    List<AnonymizedListingEntity> listings,
    DateTime since,
    Random random, {
    double epsilon = 0.5,
  }) {
    final groups = <String, List<AnonymizedListingEntity>>{};
    for (final listing in listings) {
      if (listing.recordedAt.isBefore(since)) continue;
      final key = '${listing.generalizedLat}-${listing.generalizedLng}-${listing.category}';
      groups.putIfAbsent(key, () => []).add(listing);
    }

    final stats = groups.values.map((group) {
      final sample = group.first;
      return HotspotStat(
        lat: sample.generalizedLat,
        lng: sample.generalizedLng,
        category: sample.category,
        count: AddLaplaceNoise.call(group.length, random, epsilon: epsilon),
      );
    }).toList();

    stats.sort((a, b) => b.count.compareTo(a.count));
    return stats;
  }
}
