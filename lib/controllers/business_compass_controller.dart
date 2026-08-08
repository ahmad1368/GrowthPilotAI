import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_compass_insight_narrative.dart';
import 'package:growth_pilot_ai/business/compute_business_compass_metrics.dart';
import 'package:growth_pilot_ai/business/filter_transactions_by_period.dart';
import 'package:growth_pilot_ai/business/get_sector_benchmark.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/analytics_pricing_tier_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/daily_transaction_cap_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/discount_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/emergency_broadcast_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/exchange_rate_observation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/geofence_zone_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_partnership_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_tag_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/neighborhood_expansion_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/price_alert_threshold_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/promotional_offer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/task_execution_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_count_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_steering_directive_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/visitor_count_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/account_suspension_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/ad_campaign_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/asset_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/advertising_request_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/barter_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/group_purchase_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/escrow_account_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/seasonal_catalog_item_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/banner_matching_rule_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/budget_limit_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/compliance_item_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/competitor_price_observation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/competitor_sighting_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/cap_expansion_request_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/csat_rating_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/daily_transaction_cap_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/discount_campaign_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/emergency_broadcast_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/exchange_rate_observation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/feature_module_toggle_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/geofence_zone_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/store_profile_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_category_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_item_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_cost_layer_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_stock_take_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/linked_account_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/marketing_campaign_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_branch_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_config_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_partnership_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_tag_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/neighborhood_expansion_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/analytics_pricing_tier_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/price_alert_threshold_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/promotional_offer_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/service_restriction_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/purchase_order_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/goods_receipt_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/review_feedback_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/rewarded_unlock_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/scheduled_task_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/task_execution_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/staff_shift_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/stock_movement_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/stock_reservation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/store_profile_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traffic_count_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traffic_steering_directive_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/vendor_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/visitor_count_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/warranty_claim_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/waste_log_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/staff_shift_entity.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/core/enum/compass_period.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';

/// Drives the Business Compass screen (Issue #84): computes the user's own
/// "Success DNA" vector from local transactions and compares it against a
/// mocked sector benchmark (Issue #83), since no backend analysis pipeline
/// exists in this repo.
class BusinessCompassController extends GetxController {
  late TransactionRepository _transactions;
  late WasteLogRepository _wasteLog;
  late BudgetLimitRepository _budgetLimits;
  late LinkedAccountRepository _linkedAccounts;
  late ComplianceItemRepository _complianceItems;
  late StoreProfileRepository _storeProfile;
  late InventoryItemRepository _inventoryItems;
  late InventoryCategoryRepository _inventoryCategories;
  late InventoryStockTakeRepository _stockTakes;
  late VendorRepository _vendors;
  late PurchaseOrderRepository _purchaseOrders;
  late GoodsReceiptRepository _goodsReceipts;
  late StockMovementRepository _stockMovements;
  late StockReservationRepository _stockReservations;
  late InventoryCostLayerRepository _costLayers;
  late AdCampaignRepository _adCampaigns;
  late DiscountCampaignRepository _discountCampaigns;
  late StaffShiftRepository _staffShifts;
  late CsatRatingRepository _csatRatings;
  late CompetitorPriceObservationRepository _competitorPrices;
  late VisitorCountRepository _visitorCounts;
  late ExchangeRateObservationRepository _exchangeRateObservations;
  late CompetitorSightingRepository _competitorSightings;
  late ReviewFeedbackRepository _reviewFeedback;
  late NeighborhoodExpansionRepository _neighborhoodExpansions;
  late MerchantPartnershipRepository _merchantPartnerships;
  late TrafficCountRepository _trafficCounts;
  late MerchantBranchRepository _merchantBranches;
  late PromotionalOfferRepository _promotionalOffers;
  late AnalyticsPricingTierRepository _analyticsPricingTiers;
  late ServiceRestrictionRepository _serviceRestrictions;
  late MerchantConfigRepository _merchantConfigs;
  late FeatureModuleToggleRepository _featureModuleToggles;
  late PriceAlertThresholdRepository _priceAlertThreshold;
  late AccountSuspensionRepository _accountSuspensions;
  late MerchantTagRepository _merchantTags;
  late AuditLogRepository _auditLogs;
  late DailyTransactionCapRepository _dailyTransactionCap;
  late CapExpansionRequestRepository _capExpansionRequests;
  late EmergencyBroadcastRepository _emergencyBroadcasts;
  late GeofenceZoneRepository _geofenceZones;
  late AdvertisingRequestRepository _advertisingRequests;
  late BannerMatchingRuleRepository _bannerMatchingRules;
  late RewardedUnlockRepository _rewardedUnlocks;
  late ScheduledTaskRepository _scheduledTasks;
  late TaskExecutionLogRepository _taskExecutionLogs;
  late AssetListingRepository _assetListings;
  late BarterListingRepository _barterListings;
  late GroupPurchaseRepository _groupPurchases;
  late EscrowAccountRepository _escrowAccounts;
  late SeasonalCatalogItemRepository _seasonalCatalog;
  late MarketingCampaignRepository _marketingCampaigns;

  final selectedSector = BusinessSector.tech.obs;
  final selectedPeriod = CompassPeriod.monthly.obs;
  final userMetrics = const BusinessCompassMetrics(
    liquidityRatio: 0,
    burnVelocity: 0.5,
    vendorDiversity: 0,
    paymentPunctuality: 0,
    profitMargin: 0,
  ).obs;
  DateTime lastUpdatedAt = DateTime.now();

  BusinessCompassMetrics get sectorMetrics =>
      GetSectorBenchmark.call(selectedSector.value);

  /// The Business Compass rendered as a pluggable report bundle (Issue
  /// #111), instead of the screen hardcoding which widgets to show.
  List<ReportWidgetSpec> get reportSpecs {
    final sector = sectorMetrics;
    return [
      ReportWidgetSpec(
        id: 'RADAR_CHART',
        title: 'Success DNA',
        data: {'user': userMetrics.value, 'sector': sector},
      ),
      ReportWidgetSpec(
        id: 'INSIGHT_TEXT',
        title: 'Strategy Insight',
        data: {
          'narrative':
              BuildCompassInsightNarrative.call(userMetrics.value, sector)
        },
      ),
      ReportWidgetSpec(
        id: 'METRIC_LEGEND',
        title: 'Axis Breakdown',
        data: {'user': userMetrics.value},
      ),
      ReportWidgetSpec(
        id: 'PROFIT_MARGIN_CHART',
        title: 'Profit Margin Analysis',
        data: {
          'transactions': _transactions.getAll(),
          'bannerRules': _bannerMatchingRules.getAll(),
          'adRequests': _advertisingRequests.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'SEASONAL_DEMAND_CHART',
        title: 'Seasonal Demand',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'PL_REPORT',
        title: 'P&L Report',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'BRAND_PENETRATION_INDEX',
        title: 'Brand Penetration Index',
        data: {
          'transactions': _transactions.getAll(),
          'sector': selectedSector.value,
        },
      ),
      ReportWidgetSpec(
        id: 'CATEGORY_PROFITABILITY',
        title: 'Profitability by Category',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'TRAFFIC_ANALYSIS',
        title: 'Peak Hours Traffic',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'OVERHEAD_ANALYSIS',
        title: 'Operating Expense & Overhead',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'CASH_FLOW_FORECAST',
        title: 'Cash Flow Forecast',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'SUPPLIER_SCORECARD',
        title: 'Supplier Price Scorecard',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'INFLATION_IMPACT',
        title: 'Inflation Impact Simulator',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'WASTE_LOG',
        title: 'Food Waste & Spoilage',
        data: {'wasteEntries': _wasteLog.getAll()},
      ),
      ReportWidgetSpec(
        id: 'CATEGORY_ELASTICITY',
        title: 'Service Price Elasticity',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'BUDGET_VARIANCE',
        title: 'Budget Variance Alerts',
        data: {
          'transactions': _transactions.getAll(),
          'limits': _budgetLimits.getAll()
        },
      ),
      ReportWidgetSpec(
        id: 'FINANCIAL_HEALTH',
        title: 'Financial Health & Liquidity',
        data: {'accounts': _linkedAccounts.getAll()},
      ),
      ReportWidgetSpec(
        id: 'SEASONAL_OVERHEAD_CHART',
        title: 'Seasonal Energy & Maintenance Cost',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'HOLIDAY_IMPACT',
        title: 'Holiday Sales Impact',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'COMPLIANCE_RISK',
        title: 'Legal & Compliance Risk',
        data: {'items': _complianceItems.getAll()},
      ),
      ReportWidgetSpec(
        id: 'REGIONAL_AFFORDABILITY',
        title: 'Target Region Purchasing Power Fit',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'SPACE_PRODUCTIVITY',
        title: 'Commercial Space Productivity Index',
        data: {
          'transactions': _transactions.getAll(),
          'storeProfile': _storeProfile.get()
        },
      ),
      ReportWidgetSpec(
        id: 'ANNUAL_PROFIT_FORECAST',
        title: 'Annual Profit Forecast',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'INVENTORY_STOCK',
        title: 'Inventory Management',
        data: {
          'items': _inventoryItems.getAll(),
          'categories': _inventoryCategories.getAll(),
          'vendors': _vendors.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'STOCK_TAKE',
        title: 'Periodic Stock Take & Reconciliation',
        data: {
          'records': _stockTakes.getAll(),
          'items': _inventoryItems.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'SUPPLIER_DIRECTORY',
        title: 'Local Supplier Directory',
        data: {'vendors': _vendors.getAll()},
      ),
      ReportWidgetSpec(
        id: 'PURCHASE_ORDER',
        title: 'Automated Purchase Orders',
        data: {
          'orders': _purchaseOrders.getAll(),
          'items': _inventoryItems.getAll()
        },
      ),
      ReportWidgetSpec(
        id: 'GOODS_RECEIPT',
        title: 'Goods Receipt & Invoice Matching',
        data: {
          'receipts': _goodsReceipts.getAll(),
          'orders': _purchaseOrders.getAll()
        },
      ),
      ReportWidgetSpec(
        id: 'STOCK_MOVEMENT',
        title: 'Real-Time Stock Tracking',
        data: {
          'movements': _stockMovements.getAll(),
          'items': _inventoryItems.getAll(),
          'reservations': _stockReservations.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'INVENTORY_VALUATION',
        title: 'Inventory Valuation Reporting',
        data: {
          'items': _inventoryItems.getAll(),
          'layers': _costLayers.getAll()
        },
      ),
      ReportWidgetSpec(
        id: 'INVENTORY_TURNOVER_AGING',
        title: 'Turnover & Aging Dashboard',
        data: {
          'items': _inventoryItems.getAll(),
          'movements': _stockMovements.getAll(),
          'layers': _costLayers.getAll(),
          'sector': selectedSector.value,
        },
      ),
      ReportWidgetSpec(
        id: 'DEAD_STOCK_LIQUIDATION',
        title: 'Dead Stock Liquidation',
        data: {
          'items': _inventoryItems.getAll(),
          'movements': _stockMovements.getAll(),
          'layers': _costLayers.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'BASKET_OPTIMIZATION',
        title: 'Smart Basket Optimization',
        data: {
          'items': _inventoryItems.getAll(),
          'movements': _stockMovements.getAll(),
          'layers': _costLayers.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'TRAFFIC_HEATMAP',
        title: 'Store Traffic Heatmap',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'PEER_BENCHMARK_COMPARISON',
        title: 'Vancouver Peer Benchmark',
        data: {'user': userMetrics.value, 'sector': sector},
      ),
      ReportWidgetSpec(
        id: 'CHURN_MONITORING',
        title: 'Customer Churn Monitoring',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'REVENUE_DEPENDENCY',
        title: 'Revenue Dependency on Loyal Customers',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'CLV_ANALYTICS',
        title: 'Customer Lifetime Value',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'PRODUCT_BUNDLING',
        title: 'Smart Product Bundling',
        data: {
          'movements': _stockMovements.getAll(),
          'items': _inventoryItems.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'CHANNEL_SALES_COMPARISON',
        title: 'Online vs In-Store Sales',
        data: {
          'movements': _stockMovements.getAll(),
          'items': _inventoryItems.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'STOCK_DEPLETION_FORECAST',
        title: 'Stock Depletion Forecast',
        data: {
          'items': _inventoryItems.getAll(),
          'movements': _stockMovements.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'PRICE_RECOMMENDATION',
        title: 'Smart Pricing Recommendations',
        data: {
          'items': _inventoryItems.getAll(),
          'movements': _stockMovements.getAll(),
          'layers': _costLayers.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'SEASONAL_ACQUISITION_IMPACT',
        title: 'Seasonal Discount Acquisition Impact',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'PAYMENT_METHOD_ANALYZER',
        title: 'Customer Payment Patterns',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'LOYALTY_PROGRAM_EFFECTIVENESS',
        title: 'Loyalty Program Effectiveness',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'AD_CAMPAIGN_ROI',
        title: 'Ad Campaign ROI',
        data: {
          'campaigns': _adCampaigns.getAll(),
          'transactions': _transactions.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'DISCOUNT_CAMPAIGN_IMPACT',
        title: 'Discount Campaign Impact',
        data: {
          'campaigns': _discountCampaigns.getAll(),
          'transactions': _transactions.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'STAFF_WORK_EFFICIENCY',
        title: 'Staff Work Efficiency',
        data: {
          'shifts': _staffShifts.getAll(),
          'transactions': _transactions.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'CSAT_SCORE_ANALYZER',
        title: 'Customer Satisfaction (CSAT)',
        data: {'ratings': _csatRatings.getAll()},
      ),
      ReportWidgetSpec(
        id: 'COMPETITOR_PRICE_COMPARISON',
        title: 'Competitor Price Comparison',
        data: {'observations': _competitorPrices.getAll()},
      ),
      ReportWidgetSpec(
        id: 'PRICE_INTELLIGENCE_ENGINE',
        title: 'Competitive Pricing Intelligence',
        data: {'observations': _competitorPrices.getAll()},
      ),
      ReportWidgetSpec(
        id: 'VISITOR_CONVERSION_RATE',
        title: 'Visitor-to-Buyer Conversion',
        data: {
          'counts': _visitorCounts.getAll(),
          'transactions': _transactions.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'EXCHANGE_RATE_IMPACT',
        title: 'Exchange Rate Impact',
        data: {'observations': _exchangeRateObservations.getAll()},
      ),
      ReportWidgetSpec(
        id: 'CHANNEL_ATTRIBUTION',
        title: 'Marketing Channel Attribution',
        data: {
          'campaigns': _adCampaigns.getAll(),
          'transactions': _transactions.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'COMPETITOR_PROXIMITY_RADAR',
        title: 'New Competitor Proximity Radar',
        data: {'sightings': _competitorSightings.getAll()},
      ),
      ReportWidgetSpec(
        id: 'REVIEW_SENTIMENT_ANALYSIS',
        title: 'Market Feedback Sentiment',
        data: {'reviews': _reviewFeedback.getAll()},
      ),
      ReportWidgetSpec(
        id: 'NEIGHBORHOOD_EXPANSION_ANALYZER',
        title: 'Adjacent Neighborhood Expansion Potential',
        data: {'evaluations': _neighborhoodExpansions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'MERCHANT_PARTNERSHIP_ANALYZER',
        title: 'Complementary Merchant Partnerships',
        data: {'partnerships': _merchantPartnerships.getAll()},
      ),
      ReportWidgetSpec(
        id: 'CONSUMER_BEHAVIOR_SEGMENTS',
        title: 'Consumer Behavior & Low-Income Demographic Fit',
        data: {'transactions': _transactions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'FOOT_VEHICLE_TRAFFIC_ANALYTICS',
        title: 'Foot and Vehicular Traffic Analytics',
        data: {
          'counts': _trafficCounts.getAll(),
          'transactions': _transactions.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'MULTI_MERCHANT_MASTER_DASHBOARD',
        title: 'Enterprise Multi-Merchant Master Dashboard',
        data: {'branches': _merchantBranches.getAll()},
      ),
      ReportWidgetSpec(
        id: 'PROMOTIONAL_OFFER_DISPATCHER',
        title: 'Targeted Offer and Promotional Dispatcher',
        data: {'offers': _promotionalOffers.getAll()},
      ),
      ReportWidgetSpec(
        id: 'ANALYTICS_PRICING_TIERS',
        title: 'Dynamic Monetization & Advanced Analytics Pricing',
        data: {'tiers': _analyticsPricingTiers.getAll()},
      ),
      ReportWidgetSpec(
        id: 'SERVICE_LOCKDOWN_ENGINE',
        title: 'Granular Service Lockdown and Restriction Engine',
        data: {'restrictions': _serviceRestrictions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'MERCHANT_CONFIG_PANEL',
        title: 'Single-User Granular Configuration Panel',
        data: {
          'configs': _merchantConfigs.getAll(),
          'suspensions': _accountSuspensions.getAll(),
          'restrictions': _serviceRestrictions.getAll(),
          'logs': _auditLogs.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'FEATURE_TOGGLE_ENGINE',
        title: 'Modular Feature Toggle Engine',
        data: {'toggles': _featureModuleToggles.getAll()},
      ),
      ReportWidgetSpec(
        id: 'PRICE_VOLATILITY_ALERT',
        title: 'Automated Price Fluctuation & Grocery Risk Alert System',
        data: {
          'observations': _competitorPrices.getAll(),
          'thresholdPercent': _priceAlertThreshold.get().thresholdPercent,
        },
      ),
      ReportWidgetSpec(
        id: 'ACCOUNT_SUSPENSION_MODULE',
        title: 'Temporary Account Suspension Module',
        data: {'suspensions': _accountSuspensions.getAll()},
      ),
      ReportWidgetSpec(
        id: 'MERCHANT_TAG_TOOL',
        title: 'Advanced Tagging & Categorization Tool',
        data: {
          'configs': _merchantConfigs.getAll(),
          'tags': _merchantTags.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'AUDIT_TRAIL_PANEL',
        title: 'Comprehensive Audit Trail & Activity Logging Panel',
        data: {'logs': _auditLogs.getAll()},
      ),
      ReportWidgetSpec(
        id: 'DAILY_TRANSACTION_CAP_ENGINE',
        title: 'Daily Transaction Cap Engine',
        data: {
          'transactions': _transactions.getAll(),
          'capAmount': _dailyTransactionCap.get().capAmount,
          'requests': _capExpansionRequests.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'EMERGENCY_BROADCAST_TOOL',
        title: 'Regional Emergency Broadcast & Messaging Tool',
        data: {'broadcasts': _emergencyBroadcasts.getAll()},
      ),
      ReportWidgetSpec(
        id: 'GEOFENCING_ACCESS_CONTROL',
        title: 'Geofencing Access Control',
        data: {'zones': _geofenceZones.getAll()},
      ),
      ReportWidgetSpec(
        id: 'IMPACT_ANALYSIS_DASHBOARD',
        title: 'Real-Time Impact Analysis & Profitability Reporting Dashboard',
        data: {'logs': _auditLogs.getAll()},
      ),
      ReportWidgetSpec(
        id: 'AD_REQUEST_DASHBOARD',
        title: 'Merchant Self-Service Advertising Request Dashboard',
        data: {'requests': _advertisingRequests.getAll()},
      ),
      ReportWidgetSpec(
        id: 'NATIVE_FEED_PROMO_CARD',
        title: 'Sponsored',
        data: {
          'requests': _advertisingRequests.getAll(),
          'sector': selectedSector.value,
        },
      ),
      ReportWidgetSpec(
        id: 'BANNER_MATCHING_RULES_PANEL',
        title: 'Contextual Banner Dispatcher',
        data: {'rules': _bannerMatchingRules.getAll()},
      ),
      ReportWidgetSpec(
        id: 'SPONSORED_SEARCH_DASHBOARD',
        title: 'Sponsored Search Results',
        data: {
          'configs': _merchantConfigs.getAll(),
          'adRequests': _advertisingRequests.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'REWARDED_UNLOCK_LOG',
        title: 'Value-Exchange Rewarded Promos',
        data: {'unlocks': _rewardedUnlocks.getAll()},
      ),
      ReportWidgetSpec(
        id: 'SCHEDULED_TASK_ENGINE',
        title: 'Advanced Background Scheduler',
        data: {
          'tasks': _scheduledTasks.getAll(),
          'logs': _taskExecutionLogs.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'MARKETING_CAMPAIGN_STUDIO',
        title: 'Marketing Campaign Studio',
        data: {'campaigns': _marketingCampaigns.getAll()},
      ),
      ReportWidgetSpec(
        id: 'TOP_RANKS_LEADERBOARD',
        title: 'Top Ranks Leaderboard',
        data: {
          'configs': _merchantConfigs.getAll(),
          'adRequests': _advertisingRequests.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'AD_CAMPAIGN_CONSTRAINT_ENGINE',
        title: 'Ad Campaign Constraint Enforcement',
        data: {'requests': _advertisingRequests.getAll()},
      ),
      ReportWidgetSpec(
        id: 'AD_PAYMENT_ACTIVATION_ENGINE',
        title: 'Automated Payment Detection & Instant Campaign Activation',
        data: {'requests': _advertisingRequests.getAll()},
      ),
      ReportWidgetSpec(
        id: 'WHOLESALE_MARKETPLACE',
        title: 'Wholesale Dead Stock Clearance',
        data: {
          'items': _inventoryItems.getAll(),
          'movements': _stockMovements.getAll(),
          'layers': _costLayers.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'ASSET_LIQUIDATION_MARKETPLACE',
        title: 'Rapid Liquidation Marketplace',
        data: {'listings': _assetListings.getAll()},
      ),
      ReportWidgetSpec(
        id: 'BARTER_EXCHANGE_MARKETPLACE',
        title: 'Barter and Goods Exchange',
        data: {'listings': _barterListings.getAll()},
      ),
      ReportWidgetSpec(
        id: 'GROUP_BUYING_COORDINATOR',
        title: 'Group Buying Coordinator',
        data: {'purchases': _groupPurchases.getAll()},
      ),
      ReportWidgetSpec(
        id: 'SMART_ESCROW_ENGINE',
        title: 'Smart Escrow and Refund Guarantee',
        data: {'accounts': _escrowAccounts.getAll()},
      ),
      ReportWidgetSpec(
        id: 'SEASONAL_PREORDER_ENGINE',
        title: 'Seasonal Advance Pre-Ordering',
        data: {'catalogItems': _seasonalCatalog.getAll()},
      ),
      ReportWidgetSpec(
        id: 'INVENTORY_RECOMMENDATION_ENGINE',
        title: 'Missing Inventory Recommendations',
        data: {
          'items': _inventoryItems.getAll(),
          'movements': _stockMovements.getAll(),
          'budgetLimits': _budgetLimits.getAll(),
        },
      ),
      ReportWidgetSpec(
        id: 'MICRO_CREDIT_FACILITY',
        title: 'Micro-Credit and Working Capital',
        data: {'transactions': _transactions.getAll()},
      ),
      const ReportWidgetSpec(
        id: 'FEE_WAIVER_INCENTIVE',
        title: 'Zero-Commission Incentive',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'BANKING_GATEWAY_ORCHESTRATION',
        title: 'Banking Gateway Integration',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'MERCHANT_DEPENDENCY_ENGINE',
        title: 'Merchant Dependency Detection',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'TIERED_COMMISSION_ENGINE',
        title: 'Tiered Commission Revenue',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'SETTLEMENT_TRACKING_DASHBOARD',
        title: 'Settlement Tracking',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'ACCOUNTING_REPORTS_ENGINE',
        title: 'Detailed Accounting Reports',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'CRA_COMPLIANCE_LOGGING_ENGINE',
        title: 'CRA Transaction Compliance Log',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'ON_DEVICE_TRANSLATION_BRIDGE',
        title: 'On-Device Translation Bridge',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'CONTACT_SYNC_FIND_FRIENDS',
        title: 'Find Friends on App',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'REFERRAL_INVITATION_ENGINE',
        title: 'Referral & Invitation Engine',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'CATALOG_LISTING_MODEL',
        title: 'Product & Service Catalog',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'AUTH_SESSION_LIFECYCLE',
        title: 'Auth Session Lifecycle',
        data: {},
      ),
      const ReportWidgetSpec(
        id: 'NEARBY_VENDOR_MAP',
        title: 'Nearby Vendor Map',
        data: {},
      ),
    ];
  }

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _transactions = TransactionRepository(store.box<TransactionEntity>());
    _wasteLog = WasteLogRepository(store.box<WasteLogEntity>());
    _budgetLimits = BudgetLimitRepository(store.box<BudgetLimitEntity>());
    _linkedAccounts = LinkedAccountRepository(store.box<LinkedAccountEntity>());
    _complianceItems =
        ComplianceItemRepository(store.box<ComplianceItemEntity>());
    _storeProfile = StoreProfileRepository(store.box<StoreProfileEntity>());
    _inventoryItems = InventoryItemRepository(store.box<InventoryItemEntity>());
    _inventoryCategories =
        InventoryCategoryRepository(store.box<InventoryCategoryEntity>());
    _stockTakes =
        InventoryStockTakeRepository(store.box<InventoryStockTakeEntity>());
    _vendors = VendorRepository(store.box<VendorEntity>());
    _purchaseOrders = PurchaseOrderRepository(store.box<PurchaseOrderEntity>());
    _goodsReceipts = GoodsReceiptRepository(store.box<GoodsReceiptEntity>());
    _stockMovements = StockMovementRepository(store.box<StockMovementEntity>());
    _stockReservations =
        StockReservationRepository(store.box<StockReservationEntity>());
    _costLayers =
        InventoryCostLayerRepository(store.box<InventoryCostLayerEntity>());
    _adCampaigns = AdCampaignRepository(store.box<AdCampaignEntity>());
    _discountCampaigns =
        DiscountCampaignRepository(store.box<DiscountCampaignEntity>());
    _staffShifts = StaffShiftRepository(store.box<StaffShiftEntity>());
    _csatRatings = CsatRatingRepository(store.box<CsatRatingEntity>());
    _competitorPrices = CompetitorPriceObservationRepository(
        store.box<CompetitorPriceObservationEntity>());
    _visitorCounts = VisitorCountRepository(store.box<VisitorCountEntity>());
    _exchangeRateObservations = ExchangeRateObservationRepository(
        store.box<ExchangeRateObservationEntity>());
    _competitorSightings =
        CompetitorSightingRepository(store.box<CompetitorSightingEntity>());
    _reviewFeedback =
        ReviewFeedbackRepository(store.box<ReviewFeedbackEntity>());
    _neighborhoodExpansions = NeighborhoodExpansionRepository(
        store.box<NeighborhoodExpansionEntity>());
    _merchantPartnerships =
        MerchantPartnershipRepository(store.box<MerchantPartnershipEntity>());
    _trafficCounts = TrafficCountRepository(store.box<TrafficCountEntity>());
    _merchantBranches =
        MerchantBranchRepository(store.box<MerchantBranchEntity>());
    _promotionalOffers =
        PromotionalOfferRepository(store.box<PromotionalOfferEntity>());
    _analyticsPricingTiers = AnalyticsPricingTierRepository(
        store.box<AnalyticsPricingTierEntity>());
    _serviceRestrictions =
        ServiceRestrictionRepository(store.box<ServiceRestrictionEntity>());
    _merchantConfigs =
        MerchantConfigRepository(store.box<MerchantConfigEntity>());
    _featureModuleToggles = FeatureModuleToggleRepository(
        store.box<FeatureModuleToggleEntity>());
    _priceAlertThreshold =
        PriceAlertThresholdRepository(store.box<PriceAlertThresholdEntity>());
    _accountSuspensions =
        AccountSuspensionRepository(store.box<AccountSuspensionEntity>());
    _merchantTags = MerchantTagRepository(store.box<MerchantTagEntity>());
    _auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
    _dailyTransactionCap =
        DailyTransactionCapRepository(store.box<DailyTransactionCapEntity>());
    _capExpansionRequests =
        CapExpansionRequestRepository(store.box<CapExpansionRequestEntity>());
    _emergencyBroadcasts =
        EmergencyBroadcastRepository(store.box<EmergencyBroadcastEntity>());
    _geofenceZones = GeofenceZoneRepository(store.box<GeofenceZoneEntity>());
    _advertisingRequests =
        AdvertisingRequestRepository(store.box<AdvertisingRequestEntity>());
    _bannerMatchingRules =
        BannerMatchingRuleRepository(store.box<BannerMatchingRuleEntity>());
    _rewardedUnlocks = RewardedUnlockRepository(store.box<RewardedUnlockEntity>());
    _scheduledTasks = ScheduledTaskRepository(store.box<ScheduledTaskEntity>());
    _taskExecutionLogs =
        TaskExecutionLogRepository(store.box<TaskExecutionLogEntity>());
    _assetListings = AssetListingRepository(store.box<AssetListingEntity>());
    _barterListings = BarterListingRepository(store.box<BarterListingEntity>());
    _groupPurchases = GroupPurchaseRepository(store.box<GroupPurchaseEntity>());
    _escrowAccounts = EscrowAccountRepository(store.box<EscrowAccountEntity>());
    _seasonalCatalog = SeasonalCatalogItemRepository(store.box<SeasonalCatalogItemEntity>());
    _marketingCampaigns =
        MarketingCampaignRepository(store.box<MarketingCampaignEntity>());
    _recompute();
  }

  void changeSector(BusinessSector sector) {
    selectedSector.value = sector;
  }

  void changePeriod(CompassPeriod period) {
    selectedPeriod.value = period;
    _recompute();
  }

  void _recompute() {
    final windowed = FilterTransactionsByPeriod.call(
        _transactions.getAll(), selectedPeriod.value, DateTime.now());
    userMetrics.value = ComputeBusinessCompassMetrics.call(windowed);
    lastUpdatedAt = DateTime.now();
  }
}
