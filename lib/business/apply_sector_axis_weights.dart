import 'package:growth_pilot_ai/core/models/chart_data_point.dart';

/// Sector-specific weighting for the Radar Chart (Issue #104 scope item 3:
/// "Weighted Comparison") — multiplies each axis's value by the sector's
/// `SectorProfile.axisWeights` (e.g. "Automotive" Mileage at 3x) before
/// #99's `ComputeRadarPolygonPoints` plots it; an axis absent from the map
/// keeps its 1x default weight.
class ApplySectorAxisWeights {
  static List<ChartDataPoint> call(
    List<ChartDataPoint> axes,
    Map<String, double> axisWeights,
  ) {
    return axes
        .map((axis) => ChartDataPoint(
              label: axis.label,
              value: axis.value * (axisWeights[axis.label] ?? 1.0),
            ))
        .toList();
  }
}
