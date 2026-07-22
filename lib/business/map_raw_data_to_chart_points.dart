import 'package:growth_pilot_ai/core/models/chart_axis_mapping.dart';
import 'package:growth_pilot_ai/core/models/chart_data_point.dart';

/// Turns a raw `{key: value}` payload into the axis order a chart widget
/// expects, by following a [ChartAxisMapping] list (Issue #112). Lets one
/// chart widget render entirely different axes for different categories
/// (e.g. "iPhone" vs. "Toyota Corolla") just by swapping the mapping.
class MapRawDataToChartPoints {
  static List<ChartDataPoint> call(
    Map<String, dynamic> rawData,
    List<ChartAxisMapping> mapping,
  ) {
    return mapping
        .map((axis) => ChartDataPoint(
              label: axis.label,
              value: _numberAt(rawData, axis.key),
            ))
        .toList();
  }

  /// Missing or non-numeric values default to 0.0 instead of throwing —
  /// a malformed backend payload must never crash the chart.
  static double _numberAt(Map<String, dynamic> rawData, String key) {
    final raw = rawData[key];
    if (raw is num) return raw.toDouble();
    return 0.0;
  }
}
