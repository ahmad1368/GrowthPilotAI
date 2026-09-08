import 'dart:async';

import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/error/failure_mapper.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart'; // اضافه شدن لاگر
import '../core/data/repositories/transaction_repository.dart';
import '../core/data/entities/transaction_entity.dart';
import '../core/data/entities/category_entity.dart';
import '../core/data/entities/vendor_entity.dart';
import '../services/environment_service.dart';
import '../objectbox.g.dart';

class TransactionController extends GetxController {
  // ۱. لیست‌های مشاهده‌گر
  var filteredTransactions = <TransactionEntity>[].obs;
  var isLoading = false.obs;

  // ۲. تعریف ریپازیتوری
  late TransactionRepository _repository;
  StreamSubscription<List<TransactionEntity>>? _watchSubscription;
  bool _hasActiveSearch = false;

  @override
  void onInit() {
    super.onInit();

    try {
      // پیدا کردن اینستنس دیتابیس
      final objectBoxInstance = Get.find<ObjectBox>();

      _repository = TransactionRepository(
        objectBoxInstance.store.box<TransactionEntity>(),
      );

      _seedTestData();
      fetchTransactions();

      // [Issue #17] هر تغییری در دیتابیس (درج/ویرایش/حذف) به‌صورت خودکار
      // لیست را (مگر جستجوی فعالی در جریان باشد) به‌روز می‌کند.
      _watchSubscription = _repository.watchAll().listen((_) {
        if (!_hasActiveSearch) _loadLocalData();
      });

      OmniLogger.info("TransactionController: Initialized successfully.");
    } catch (e, stack) {
      OmniLogger.error(
        title: "TransactionController Initialization Failed",
        widgetName: "TransactionController",
        message: e,
        stackTrace: stack,
      );
    }
  }

  @override
  void onClose() {
    _watchSubscription?.cancel();
    super.onClose();
  }

  /// متد اصلی برای بارگذاری داده‌ها
  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      OmniLogger.info("Fetching transactions...");

      final bool isRemote =
          Get.find<EnvironmentService>().isRemoteEnabled.value;

      if (isRemote) {
        // منطق Cloud (Vancouver Server)
        OmniLogger.warning(
            "Remote fetching is not implemented yet. Pointing to TODO.");
        // TODO: پیاده‌سازی سرویس API
      } else {
        // منطق محلی
        _loadLocalData();
      }
    } catch (e, stack) {
      // تبدیل خطا به ساختار استاندارد و نمایش/لاگ آن
      final response = FailureMapper.map<void>(e, stack: stack);
      Get.snackbar("خطا", response.message ?? "خطا در دریافت اطلاعات");
    } finally {
      isLoading.value = false;
    }
  }

  /// منطق بارگذاری داده‌های محلی
  void _loadLocalData() {
    final now = DateTime.now();
    final lastMonth = now.subtract(const Duration(days: 30));

    final results = _repository.getByDateRange(lastMonth, now);

    filteredTransactions.assignAll(results);
    OmniLogger.info(
        "Local transactions loaded: ${results.length} items found.");
  }

  /// متد جستجوی متنی
  void searchTransactions(String query) {
    _hasActiveSearch = query.isNotEmpty;
    if (query.isEmpty) {
      fetchTransactions();
      return;
    }

    final results = _repository.search(query);
    filteredTransactions.assignAll(results);
    OmniLogger.info(
        "Search performed for: '$query'. Results: ${results.length}");
  }

  /// [Issue #839] داده‌های واقعی‌نما برای سناریوی یک شرکت تولید و نصب هندریل
  /// و شیشه محافظ بالکن ساختمان‌های بلندمرتبه در ونکوور. جایگزین سناریوی
  /// قبلی (شرکت مشاوره فناوری) — هر بار اجرای برنامه، داده‌های قبلی پاک و
  /// این مجموعه دوباره درج می‌شود (این متد فقط برای داده‌ی تست/توسعه است، نه
  /// یک الگوی عمومی پاک‌سازی داده). هدف: پوشش تمام مسیرهای Repository (بازه
  /// تاریخ، جستجو، فیلتر دسته/نوع، وضعیت‌های Sync، روابط ToOne).
  void _seedTestData() {
    final objectBoxInstance = Get.find<ObjectBox>();
    final categoryBox = objectBoxInstance.store.box<CategoryEntity>();
    final vendorBox = objectBoxInstance.store.box<VendorEntity>();

    _repository.removeAll();
    categoryBox.removeAll();
    vendorBox.removeAll();

    final now = DateTime.now();
    final categories = _seedCategories(categoryBox);
    final vendors = _seedVendors(vendorBox);
    final items = _buildHandrailGlassTransactions(now, categories, vendors);

    for (final item in items) {
      _repository.insert(item);
    }
    OmniLogger.info(
        "Handrail/balcony-glass scenario test data seeded into ObjectBox (${items.length} "
        "transactions, ${categoryBox.count()} categories, ${vendorBox.count()} vendors).");
  }

  Map<String, CategoryEntity> _seedCategories(Box<CategoryEntity> categoryBox) {
    final categories = {
      'materials': CategoryEntity(
          name: "Aluminum & Steel Stock", icon: "construction", color: 0xFF607D8B),
      'glass': CategoryEntity(name: "Tempered Glass Supply", icon: "window", color: 0xFF03A9F4),
      'labor': CategoryEntity(name: "Installation Labor", icon: "engineering", color: 0xFFFF9800),
      'equipment': CategoryEntity(name: "Equipment & Tools", icon: "handyman", color: 0xFF795548),
      'utilities': CategoryEntity(name: "Utilities", icon: "bolt", color: 0xFFFFC107),
      'marketing': CategoryEntity(name: "Marketing", icon: "campaign", color: 0xFFE91E63),
      'income': CategoryEntity(name: "Client Payment", icon: "payments", color: 0xFF4CAF50),
      'insurance': CategoryEntity(name: "Permits & Insurance", icon: "verified", color: 0xFF9C27B0),
      'delivery': CategoryEntity(
          name: "Delivery & Crane Rental", icon: "local_shipping", color: 0xFF009688),
    };
    categoryBox.putMany(categories.values.toList());
    return categories;
  }

  Map<String, VendorEntity> _seedVendors(Box<VendorEntity> vendorBox) {
    final vendors = {
      'alumform': VendorEntity(name: "AlumForm Metal Supply", taxId: "222333444RT0001"),
      'guardian': VendorEntity(name: "Guardian Glass Works", taxId: "555777999RT0001"),
      'hydro': VendorEntity(name: "BC Hydro", taxId: "123456789RT0001"),
      'telus': VendorEntity(name: "Telus Business", taxId: "987654321RT0001"),
      'crane': VendorEntity(name: "Crane & Rigging Co."),
      'worksafe': VendorEntity(name: "WorkSafeBC", taxId: "666888111RT0001"),
      'google': VendorEntity(name: "Google Ads"),
      'skyline': VendorEntity(name: "Skyline Tower Developments Inc.", taxId: "111222333RT0001"),
      'harbourview': VendorEntity(name: "Harbourview Construction Group", taxId: "444555666RT0001"),
      'metro': VendorEntity(name: "Metro Highrise Builders Ltd.", taxId: "777888999RT0001"),
    };
    vendorBox.putMany(vendors.values.toList());
    return vendors;
  }

  // ترکیبی از هزینه/درآمد، بازه‌های زمانی مختلف (داخل و خارج از ۳۰ روز اخیر)،
  // وضعیت‌های Sync متفاوت (شامل یک حالت error) و یادداشت‌ها.
  List<TransactionEntity> _buildHandrailGlassTransactions(
      DateTime now, Map<String, CategoryEntity> cat, Map<String, VendorEntity> v) {
    return [
      TransactionEntity(
          description: "پرداخت مرحله‌ای پروژه هندریل - Skyline Tower Developments",
          amount: 18500.00,
          date: now,
          dbType: 1,
          dbSyncStatus: 1)
        ..category.target = cat['income']
        ..vendor.target = v['skyline'],
      TransactionEntity(
          description: "خرید پروفیل آلومینیوم هندریل",
          amount: 3240.50,
          date: now.subtract(const Duration(days: 2)),
          dbType: 0,
          dbSyncStatus: 0)
        ..category.target = cat['materials']
        ..vendor.target = v['alumform'],
      TransactionEntity(
          description: "دستمزد تیم نصب هندریل - پروژه Skyline Tower",
          amount: 5120.00,
          date: now.subtract(const Duration(days: 2)),
          dbType: 0,
          dbSyncStatus: 0)
        ..category.target = cat['labor'],
      TransactionEntity(
          description: "قبض برق کارگاه (BC Hydro)",
          amount: 312.80,
          date: now.subtract(const Duration(days: 3)),
          dbType: 0,
          dbSyncStatus: 0)
        ..category.target = cat['utilities']
        ..vendor.target = v['hydro'],
      TransactionEntity(
          description: "کمپین تبلیغاتی شیشه بالکن مسکونی",
          amount: 420.00,
          date: now.subtract(const Duration(days: 4)),
          dbType: 0,
          dbSyncStatus: 1)
        ..category.target = cat['marketing']
        ..vendor.target = v['google'],
      TransactionEntity(
          description: "سفارش پنل‌های شیشه سکوریت",
          amount: 9875.00,
          date: now.subtract(const Duration(days: 6)),
          dbType: 0,
          dbSyncStatus: 0)
        ..category.target = cat['glass']
        ..vendor.target = v['guardian'],
      TransactionEntity(
          description: "اینترنت و تلفن کارگاه (Telus Business)",
          amount: 110.00,
          date: now.subtract(const Duration(days: 10)),
          dbType: 0,
          dbSyncStatus: 0)
        ..category.target = cat['utilities']
        ..vendor.target = v['telus'],
      TransactionEntity(
          description: "اجاره جرثقیل برای نصب در طبقات بالا",
          amount: 1650.00,
          date: now.subtract(const Duration(days: 12)),
          dbType: 0,
          dbSyncStatus: 0)
        ..memo = "دسترسی سایت کار - قابل کسر مالیاتی"
        ..category.target = cat['delivery']
        ..vendor.target = v['crane'],
      TransactionEntity(
          description: "پرداخت مرحله‌ای پروژه - Harbourview Construction Group",
          amount: 24300.00,
          date: now.subtract(const Duration(days: 15)),
          dbType: 1,
          dbSyncStatus: 0)
        ..category.target = cat['income']
        ..vendor.target = v['harbourview'],
      TransactionEntity(
          description: "حق بیمه سالانه WorkSafeBC",
          amount: 1980.00,
          date: now.subtract(const Duration(days: 18)),
          dbType: 0,
          dbSyncStatus: 2)
        ..category.target = cat['insurance']
        ..vendor.target = v['worksafe'],
      TransactionEntity(
          description: "خرید دستگاه برش و پرداخت لبه شیشه",
          amount: 6800.00,
          date: now.subtract(const Duration(days: 20)),
          dbType: 0,
          dbSyncStatus: 0)
        ..memo = "دارایی ثابت - استهلاک ۵ ساله"
        ..category.target = cat['equipment'],
      TransactionEntity(
          description: "تبلیغات Google Ads برای پروژه‌های تجاری",
          amount: 355.20,
          date: now.subtract(const Duration(days: 25)),
          dbType: 0,
          dbSyncStatus: 0)
        ..category.target = cat['marketing']
        ..vendor.target = v['google'],
      TransactionEntity(
          description: "دریافت وجه تعمیر هندریل بالکن مسکونی کوچک",
          amount: 890.00,
          date: now.subtract(const Duration(days: 28)),
          dbType: 1,
          dbSyncStatus: 1)
        ..category.target = cat['income'],
      TransactionEntity(
          description: "خرید یراق‌آلات استیل ضدزنگ",
          amount: 540.75,
          date: now.subtract(const Duration(days: 29)),
          dbType: 0,
          dbSyncStatus: 0)
        ..category.target = cat['materials']
        ..vendor.target = v['alumform'],
      // خارج از بازه ۳۰ روز اخیر - برای تست فیلتر تاریخ در _loadLocalData
      TransactionEntity(
          description: "قرارداد سالانه تأمین شیشه (سال قبل)",
          amount: 15200.00,
          date: now.subtract(const Duration(days: 35)),
          dbType: 0,
          dbSyncStatus: 0)
        ..category.target = cat['glass']
        ..vendor.target = v['guardian'],
      TransactionEntity(
          description: "پرداخت قرارداد سالانه - Metro Highrise Builders",
          amount: 52000.00,
          date: now.subtract(const Duration(days: 45)),
          dbType: 1,
          dbSyncStatus: 0)
        ..category.target = cat['income']
        ..vendor.target = v['metro'],
      TransactionEntity(
          description: "بازگشت وجه واریزی اضافه به تأمین‌کننده",
          amount: 180.00,
          date: now.subtract(const Duration(hours: 3)),
          dbType: 0,
          dbSyncStatus: 1)
        ..memo = "نیازمند پیگیری با حسابداری",
    ];
  }
}
