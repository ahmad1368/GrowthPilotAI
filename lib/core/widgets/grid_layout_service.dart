/// Decides how many grid cells a report widget spans on the [DynamicReportGrid]
/// (Issue #113). Analytical widgets that need room to breathe (a radar chart)
/// take the full row; small metrics/text widgets share a row two-up.
class GridLayoutService {
  static const _fullWidthIds = {
    'RADAR_CHART',
    'MAPPED_RADAR_CHART',
    'PROFIT_MARGIN_CHART',
    'SEASONAL_DEMAND_CHART',
    'PL_REPORT',
    'CATEGORY_PROFITABILITY',
    'TRAFFIC_ANALYSIS',
    'OVERHEAD_ANALYSIS',
    'CASH_FLOW_FORECAST',
    'SUPPLIER_SCORECARD',
  };

  /// [totalColumns] must be even so half-width tiles always pair up without
  /// leaving a gap.
  static int getCrossAxisCellCount(String widgetId, int totalColumns) {
    if (_fullWidthIds.contains(widgetId)) return totalColumns;
    return totalColumns ~/ 2;
  }
}
