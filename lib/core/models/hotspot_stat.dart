import 'package:flutter/foundation.dart';

/// One "busiest area" bucket from [ComputeHotspotStats] (Issue #95) —
/// [count] is already Differential-Privacy noised, never a raw count.
@immutable
class HotspotStat {
  final double lat;
  final double lng;
  final String category;
  final int count;

  const HotspotStat({
    required this.lat,
    required this.lng,
    required this.category,
    required this.count,
  });

  @override
  bool operator ==(Object other) =>
      other is HotspotStat &&
      lat == other.lat &&
      lng == other.lng &&
      category == other.category &&
      count == other.count;

  @override
  int get hashCode => Object.hash(lat, lng, category, count);
}
