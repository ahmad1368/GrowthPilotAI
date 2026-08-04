import 'package:growth_pilot_ai/core/models/widget_config_option.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_registry.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/account_suspension_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_campaign_roi_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/audit_trail_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/analytics_pricing_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/annual_profit_forecast_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/basket_optimization_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/brand_penetration_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_variance_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cash_flow_forecast_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_elasticity_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_profitability_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/channel_attribution_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/channel_sales_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/churn_monitoring_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/clv_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_price_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_proximity_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_risk_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/consumer_behavior_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/csat_summary_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/daily_cap_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/dead_stock_liquidation_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/discount_campaign_impact_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/exchange_rate_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/feature_toggle_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/holiday_impact_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inflation_impact_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/insight_narrative_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_turnover_aging_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/loyalty_program_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/mapped_radar_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_branch_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_config_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_partnership_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_tag_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/metric_legend_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/neighborhood_expansion_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/overhead_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/payment_method_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/peer_benchmark_comparison_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_recommendation_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_volatility_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/product_bundle_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promotional_offer_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/radar_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/regional_affordability_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/revenue_dependency_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/review_sentiment_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_acquisition_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_demand_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_overhead_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/service_restriction_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/space_productivity_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/staff_efficiency_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_depletion_forecast_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_directory_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_scorecard_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_analytics_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_heatmap_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_steering_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/conversion_rate_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/warranty_profitability_report_widget.dart';
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
    ReportWidgetRegistry.register(
        'PRODUCT_BUNDLING',
        (spec) =>
            ProductBundleReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'CHANNEL_SALES_COMPARISON',
        (spec) =>
            ChannelSalesReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'STOCK_DEPLETION_FORECAST',
        (spec) => StockDepletionForecastReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'PRICE_RECOMMENDATION',
        (spec) =>
            PriceRecommendationReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'SEASONAL_ACQUISITION_IMPACT',
        (spec) =>
            SeasonalAcquisitionReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'PAYMENT_METHOD_ANALYZER',
        (spec) =>
            PaymentMethodReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'LOYALTY_PROGRAM_EFFECTIVENESS',
        (spec) =>
            LoyaltyProgramReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'AD_CAMPAIGN_ROI',
        (spec) =>
            AdCampaignRoiReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'DISCOUNT_CAMPAIGN_IMPACT',
        (spec) => DiscountCampaignImpactReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'STAFF_WORK_EFFICIENCY',
        (spec) =>
            StaffEfficiencyReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'CSAT_SCORE_ANALYZER',
        (spec) =>
            CsatSummaryReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'COMPETITOR_PRICE_COMPARISON',
        (spec) =>
            CompetitorPriceReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'VISITOR_CONVERSION_RATE',
        (spec) =>
            ConversionRateReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'EXCHANGE_RATE_IMPACT',
        (spec) =>
            ExchangeRateReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'CHANNEL_ATTRIBUTION',
        (spec) => ChannelAttributionReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'COMPETITOR_PROXIMITY_RADAR',
        (spec) => CompetitorProximityReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'REVIEW_SENTIMENT_ANALYSIS',
        (spec) =>
            ReviewSentimentReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'NEIGHBORHOOD_EXPANSION_ANALYZER',
        (spec) => NeighborhoodExpansionReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'MERCHANT_PARTNERSHIP_ANALYZER',
        (spec) => MerchantPartnershipReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'CONSUMER_BEHAVIOR_SEGMENTS',
        (spec) => ConsumerBehaviorReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'FOOT_VEHICLE_TRAFFIC_ANALYTICS',
        (spec) => TrafficAnalyticsReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'MULTI_MERCHANT_MASTER_DASHBOARD',
        (spec) => MerchantBranchReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'PROMOTIONAL_OFFER_DISPATCHER',
        (spec) => PromotionalOfferReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'ANALYTICS_PRICING_TIERS',
        (spec) => AnalyticsPricingReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'SERVICE_LOCKDOWN_ENGINE',
        (spec) => ServiceRestrictionReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'MERCHANT_CONFIG_PANEL',
        (spec) =>
            MerchantConfigReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'FEATURE_TOGGLE_ENGINE',
        (spec) =>
            FeatureToggleReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'PRICE_VOLATILITY_ALERT',
        (spec) =>
            PriceVolatilityReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'ACCOUNT_SUSPENSION_MODULE',
        (spec) => AccountSuspensionReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'MERCHANT_TAG_TOOL',
        (spec) => MerchantTagReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'AUDIT_TRAIL_PANEL',
        (spec) => AuditTrailReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'DAILY_TRANSACTION_CAP_ENGINE',
        (spec) => DailyCapReportWidget(data: spec.data, title: spec.title));
  }

  /// Registers each widget's config side-panel options (Issue #115).
  static void registerConfig() {
    WidgetConfigRegistry.register('RADAR_CHART', const [
      WidgetConfigOption(key: 'showBenchmark', label: 'Show sector benchmark'),
    ]);
  }
}
