import 'package:flutter/foundation.dart';

/// One labeled value on a generic chart axis (Issue #112) — the common
/// output shape [MapRawDataToChartPoints] produces regardless of which
/// category's raw payload it came from.
@immutable
class ChartDataPoint {
  final String label;
  final double value;

  const ChartDataPoint({required this.label, required this.value});
}
