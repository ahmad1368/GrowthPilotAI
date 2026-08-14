import 'package:flutter/foundation.dart';

/// Transaction-count for one hour (0-23) or weekday (0=Mon..6=Sun) bucket
/// (Issue #365) — each transaction stands in for one customer visit, since
/// this app has no dedicated foot-traffic/POS check-in data.
@immutable
class TrafficPoint {
  final int bucket;
  final int count;
  final bool isPeak;

  const TrafficPoint({
    required this.bucket,
    required this.count,
    this.isPeak = false,
  });
}
