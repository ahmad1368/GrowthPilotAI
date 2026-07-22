/// Decides how many grid cells a report widget spans on the [DynamicReportGrid]
/// (Issue #113). Analytical widgets that need room to breathe (a radar chart)
/// take the full row; small metrics/text widgets share a row two-up.
class GridLayoutService {
  static const _fullWidthIds = {'RADAR_CHART', 'MAPPED_RADAR_CHART'};

  /// [totalColumns] must be even so half-width tiles always pair up without
  /// leaving a gap.
  static int getCrossAxisCellCount(String widgetId, int totalColumns) {
    if (_fullWidthIds.contains(widgetId)) return totalColumns;
    return totalColumns ~/ 2;
  }
}
