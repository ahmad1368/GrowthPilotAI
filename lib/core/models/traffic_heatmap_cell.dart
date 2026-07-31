import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/traffic_day_part.dart';

/// Transaction-count for one day-of-week x day-part cell (Issue #354),
/// with [intensity] normalized 0.0-1.0 against the grid's busiest cell.
@immutable
class TrafficHeatmapCell {
  final int dayOfWeek;
  final TrafficDayPart dayPart;
  final int count;
  final double intensity;
  final bool isPeak;

  const TrafficHeatmapCell({
    required this.dayOfWeek,
    required this.dayPart,
    required this.count,
    required this.intensity,
    this.isPeak = false,
  });
}
