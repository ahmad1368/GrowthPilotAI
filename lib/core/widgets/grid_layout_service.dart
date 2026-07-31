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
    'INFLATION_IMPACT',
    'WASTE_LOG',
    'CATEGORY_ELASTICITY',
    'BUDGET_VARIANCE',
    'SEASONAL_OVERHEAD_CHART',
    'HOLIDAY_IMPACT',
    'COMPLIANCE_RISK',
    'INVENTORY_STOCK',
    'STOCK_TAKE',
    'SUPPLIER_DIRECTORY',
    'PURCHASE_ORDER',
    'GOODS_RECEIPT',
    'STOCK_MOVEMENT',
    'INVENTORY_VALUATION',
    'INVENTORY_TURNOVER_AGING',
    'DEAD_STOCK_LIQUIDATION',
    'BASKET_OPTIMIZATION',
    'TRAFFIC_HEATMAP',
    'PEER_BENCHMARK_COMPARISON',
    'CHURN_MONITORING',
    'REVENUE_DEPENDENCY',
    'CLV_ANALYTICS',
    'PRODUCT_BUNDLING',
    'CHANNEL_SALES_COMPARISON',
    'STOCK_DEPLETION_FORECAST',
  };

  /// [totalColumns] must be even so half-width tiles always pair up without
  /// leaving a gap.
  static int getCrossAxisCellCount(String widgetId, int totalColumns) {
    if (_fullWidthIds.contains(widgetId)) return totalColumns;
    return totalColumns ~/ 2;
  }
}
