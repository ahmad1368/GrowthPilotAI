import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_compass_insight_narrative.dart';
import 'package:growth_pilot_ai/business/compute_business_compass_metrics.dart';
import 'package:growth_pilot_ai/business/filter_transactions_by_period.dart';
import 'package:growth_pilot_ai/business/get_sector_benchmark.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/discount_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/ad_campaign_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/budget_limit_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/compliance_item_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/csat_rating_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/discount_campaign_repository.dart';
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
import 'package:growth_pilot_ai/core/data/repositories/purchase_order_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/goods_receipt_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/staff_shift_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/stock_movement_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/stock_reservation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/store_profile_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/vendor_repository.dart';
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
        data: {'transactions': _transactions.getAll()},
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
