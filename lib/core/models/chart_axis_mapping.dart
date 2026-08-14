import 'package:flutter/foundation.dart';

/// One entry of a chart's mapping config (Issue #112): which [key] to pull
/// out of a raw data payload, and what [label] to show for it on the axis.
/// Stands in for the JSON `mapping` array a backend would send.
@immutable
class ChartAxisMapping {
  final String key;
  final String label;

  const ChartAxisMapping({required this.key, required this.label});
}
