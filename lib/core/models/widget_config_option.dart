import 'package:flutter/foundation.dart';

/// One "knob" a report widget exposes in its config side-panel (Issue
/// #115). Scoped to a boolean toggle for now — the only config value this
/// app has anything real to drive (e.g. RADAR_CHART's sector-benchmark
/// overlay); Slider/Dropdown controls need real numeric/categorical data
/// this app doesn't have yet.
@immutable
class WidgetConfigOption {
  final String key;
  final String label;
  final bool defaultValue;

  const WidgetConfigOption({
    required this.key,
    required this.label,
    this.defaultValue = true,
  });
}
