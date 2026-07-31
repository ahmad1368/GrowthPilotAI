import 'package:growth_pilot_ai/core/models/widget_config_option.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_registry.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/annual_profit_forecast_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/basket_optimization_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/brand_penetration_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_variance_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cash_flow_forecast_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_elasticity_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_profitability_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/churn_monitoring_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/clv_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_risk_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/dead_stock_liquidation_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/holiday_impact_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inflation_impact_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/insight_narrative_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/mapped_radar_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/metric_legend_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/overhead_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/peer_benchmark_comparison_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/radar_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/regional_affordability_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/revenue_dependency_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_demand_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_overhead_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/space_productivity_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_directory_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_scorecard_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_heatmap_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_log_report_widget.dart';

/// One-time registration of the analytics report widgets into
/// [ReportWidgetRegistry] (Issue #111). Adding a new widget type elsewhere
/// only needs one more line like these.
class ReportWidgetsBootstrap {
  static void register() {
    ReportWidgetRegistry.register('RADAR_CHART',
        (spec) => RadarReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('METRIC_LEGEND',
        (spec) => MetricLegendReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'INSIGHT_TEXT',
        (spec) =>
            InsightNarrativeReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('MAPPED_RADAR_CHART',
        (spec) => MappedRadarReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('PROFIT_MARGIN_CHART',
        (spec) => ProfitMarginReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'SEASONAL_DEMAND_CHART',
        (spec) =>
            SeasonalDemandReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('PL_REPORT',
        (spec) => PLReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'BRAND_PENETRATION_INDEX',
        (spec) =>
            BrandPenetrationReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'CATEGORY_PROFITABILITY',
        (spec) => CategoryProfitabilityReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('TRAFFIC_ANALYSIS',
        (spec) => TrafficReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('OVERHEAD_ANALYSIS',
        (spec) => OverheadReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'CASH_FLOW_FORECAST',
        (spec) =>
            CashFlowForecastReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'SUPPLIER_SCORECARD',
        (spec) =>
            SupplierScorecardReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'INFLATION_IMPACT',
        (spec) =>
            InflationImpactReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('WASTE_LOG',
        (spec) => WasteLogReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'CATEGORY_ELASTICITY',
        (spec) =>
            CategoryElasticityReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'BUDGET_VARIANCE',
        (spec) =>
            BudgetVarianceReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'FINANCIAL_HEALTH',
        (spec) =>
            FinancialHealthReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'SEASONAL_OVERHEAD_CHART',
        (spec) =>
            SeasonalOverheadReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'HOLIDAY_IMPACT',
        (spec) =>
            HolidayImpactReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'COMPLIANCE_RISK',
        (spec) =>
            ComplianceRiskReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'REGIONAL_AFFORDABILITY',
        (spec) => RegionalAffordabilityReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'SPACE_PRODUCTIVITY',
        (spec) =>
            SpaceProductivityReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'ANNUAL_PROFIT_FORECAST',
        (spec) => AnnualProfitForecastReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('INVENTORY_STOCK',
        (spec) => InventoryReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('STOCK_TAKE',
        (spec) => StockTakeReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'SUPPLIER_DIRECTORY',
        (spec) =>
            SupplierDirectoryReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'PURCHASE_ORDER',
        (spec) =>
            PurchaseOrderReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('GOODS_RECEIPT',
        (spec) => GoodsReceiptReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'STOCK_MOVEMENT',
        (spec) =>
            StockMovementReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'INVENTORY_VALUATION',
        (spec) =>
            InventoryValuationReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'INVENTORY_TURNOVER_AGING',
        (spec) => InventoryTurnoverAgingReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'DEAD_STOCK_LIQUIDATION',
        (spec) => DeadStockLiquidationReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'BASKET_OPTIMIZATION',
        (spec) => BasketOptimizationReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'TRAFFIC_HEATMAP',
        (spec) =>
            TrafficHeatmapReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'PEER_BENCHMARK_COMPARISON',
        (spec) => PeerBenchmarkComparisonReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'CHURN_MONITORING',
        (spec) =>
            ChurnMonitoringReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'REVENUE_DEPENDENCY',
        (spec) =>
            RevenueDependencyReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register('CLV_ANALYTICS',
        (spec) => ClvReportWidget(data: spec.data, title: spec.title));
  }

  /// Registers each widget's config side-panel options (Issue #115).
  static void registerConfig() {
    WidgetConfigRegistry.register('RADAR_CHART', const [
      WidgetConfigOption(key: 'showBenchmark', label: 'Show sector benchmark'),
    ]);
  }
}
