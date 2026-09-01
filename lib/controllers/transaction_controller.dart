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

  /// ایجاد داده‌های واقعی‌نما برای سناریوی فرضی یک کسب‌وکار کوچک در ونکوور
  /// هدف: پوشش دادن تمام مسیرهای Repository (بازه تاریخ، جستجو، فیلتر بر اساس
  /// دسته/نوع، وضعیت‌های Sync و روابط ToOne) برای تست صحت برنامه.
  void _seedTestData() {
    if (_repository.getAll().isNotEmpty) return;

    final objectBoxInstance = Get.find<ObjectBox>();
    final categoryBox = objectBoxInstance.store.box<CategoryEntity>();
    final vendorBox = objectBoxInstance.store.box<VendorEntity>();

    final now = DateTime.now();

    // ۱. دسته‌بندی‌ها
    final catSoftware = CategoryEntity(
        name: "Software & SaaS", icon: "laptop_mac", color: 0xFF2196F3);
    final catMarketing =
        CategoryEntity(name: "Marketing", icon: "campaign", color: 0xFFFF9800);
    final catUtilities =
        CategoryEntity(name: "Utilities", icon: "bolt", color: 0xFFFFC107);
    final catOffice = CategoryEntity(
        name: "Office Supplies", icon: "chair", color: 0xFF795548);
    final catTravel =
        CategoryEntity(name: "Travel", icon: "flight", color: 0xFF9C27B0);
    final catIncome = CategoryEntity(
        name: "Client Payment", icon: "payments", color: 0xFF4CAF50);
    final catEquipment =
        CategoryEntity(name: "Equipment", icon: "devices", color: 0xFF607D8B);

    categoryBox.putMany([
      catSoftware,
      catMarketing,
      catUtilities,
      catOffice,
      catTravel,
      catIncome,
      catEquipment,
    ]);

    // ۲. فروشندگان / مشتریان (با شماره مالیاتی HST برای نمونه‌های کانادایی)
    final vGoogle = VendorEntity(name: "Google Cloud");
    final vAzure = VendorEntity(name: "Microsoft Azure");
    final vMeta = VendorEntity(name: "Meta Ads");
    final vHydro = VendorEntity(name: "BC Hydro", taxId: "123456789RT0001");
    final vTelus =
        VendorEntity(name: "Telus Business", taxId: "987654321RT0001");
    final vStaples =
        VendorEntity(name: "Staples Canada", taxId: "555666777RT0001");
    final vAirCanada = VendorEntity(name: "Air Canada");
    final vNorthwind =
        VendorEntity(name: "Northwind Traders Inc.", taxId: "111222333RT0001");
    final vVanTech = VendorEntity(
        name: "Vancouver Tech Solutions", taxId: "444555666RT0001");

    vendorBox.putMany([
      vGoogle,
      vAzure,
      vMeta,
      vHydro,
      vTelus,
      vStaples,
      vAirCanada,
      vNorthwind,
      vVanTech,
    ]);

    // ۳. تراکنش‌ها: ترکیبی از هزینه/درآمد، بازه‌های زمانی مختلف
    // (داخل و خارج از ۳۰ روز اخیر)، وضعیت‌های Sync متفاوت و یادداشت‌ها
    final items = <TransactionEntity>[
      TransactionEntity(
        description: "اشتراک ماهانه Google Cloud",
        amount: 89.50,
        date: now,
        dbType: 0,
        dbSyncStatus: 1, // pending
      )
        ..category.target = catSoftware
        ..vendor.target = vGoogle,
      TransactionEntity(
        description: "دریافت وجه پروژه از Northwind Traders",
        amount: 4500.00,
        date: now.subtract(const Duration(days: 2)),
        dbType: 1,
        dbSyncStatus: 0, // synced
      )
        ..category.target = catIncome
        ..vendor.target = vNorthwind,
      TransactionEntity(
        description: "قبض برق دفتر کار (BC Hydro)",
        amount: 142.35,
        date: now.subtract(const Duration(days: 3)),
        dbType: 0,
        dbSyncStatus: 0,
      )
        ..category.target = catUtilities
        ..vendor.target = vHydro,
      TransactionEntity(
        description: "کمپین تبلیغاتی Meta Ads",
        amount: 310.00,
        date: now.subtract(const Duration(days: 4)),
        dbType: 0,
        dbSyncStatus: 1,
      )
        ..category.target = catMarketing
        ..vendor.target = vMeta,
      TransactionEntity(
        description: "خرید صندلی اداری از Staples",
        amount: 219.99,
        date: now.subtract(const Duration(days: 6)),
        dbType: 0,
        dbSyncStatus: 0,
      )
        ..category.target = catOffice
        ..vendor.target = vStaples,
      TransactionEntity(
        description: "اینترنت دفتر (Telus Business)",
        amount: 95.00,
        date: now.subtract(const Duration(days: 10)),
        dbType: 0,
        dbSyncStatus: 0,
      )
        ..category.target = catUtilities
        ..vendor.target = vTelus,
      TransactionEntity(
        description: "بلیط هواپیما - جلسه با مشتری در تورنتو",
        amount: 486.20,
        date: now.subtract(const Duration(days: 12)),
        dbType: 0,
        dbSyncStatus: 0,
      )
        ..memo = "سفر کاری - قابل کسر مالیاتی"
        ..category.target = catTravel
        ..vendor.target = vAirCanada,
      TransactionEntity(
        description: "دریافت وجه مشاوره از Vancouver Tech Solutions",
        amount: 7800.00,
        date: now.subtract(const Duration(days: 15)),
        dbType: 1,
        dbSyncStatus: 0,
      )
        ..category.target = catIncome
        ..vendor.target = vVanTech,
      TransactionEntity(
        description: "هاست سرور روی Microsoft Azure",
        amount: 154.75,
        date: now.subtract(const Duration(days: 18)),
        dbType: 0,
        dbSyncStatus: 2, // error - برای تست حالت خطای Sync
      )
        ..category.target = catSoftware
        ..vendor.target = vAzure,
      TransactionEntity(
        description: "خرید لپ‌تاپ جدید برای تیم توسعه",
        amount: 2100.00,
        date: now.subtract(const Duration(days: 20)),
        dbType: 0,
        dbSyncStatus: 0,
      )
        ..memo = "دارایی ثابت - استهلاک ۳ ساله"
        ..category.target = catEquipment,
      TransactionEntity(
        description: "تبلیغات Google Ads",
        amount: 275.40,
        date: now.subtract(const Duration(days: 25)),
        dbType: 0,
        dbSyncStatus: 0,
      )
        ..category.target = catMarketing
        ..vendor.target = vGoogle,
      TransactionEntity(
        description: "دریافت وجه پروژه کوچک از مشتری جدید",
        amount: 350.00,
        date: now.subtract(const Duration(days: 28)),
        dbType: 1,
        dbSyncStatus: 1,
      )..category.target = catIncome,
      TransactionEntity(
        description: "لوازم اداری متفرقه از Staples",
        amount: 63.10,
        date: now.subtract(const Duration(days: 29)),
        dbType: 0,
        dbSyncStatus: 0,
      )
        ..category.target = catOffice
        ..vendor.target = vStaples,
      // خارج از بازه ۳۰ روز اخیر - برای اطمینان از صحت فیلتر تاریخ در _loadLocalData
      TransactionEntity(
        description: "قرارداد سالانه هاست Google Cloud (سال قبل)",
        amount: 980.00,
        date: now.subtract(const Duration(days: 35)),
        dbType: 0,
        dbSyncStatus: 0,
      )
        ..category.target = catSoftware
        ..vendor.target = vGoogle,
      TransactionEntity(
        description: "دریافت وجه قرارداد سالانه از مشتری قدیمی",
        amount: 12000.00,
        date: now.subtract(const Duration(days: 45)),
        dbType: 1,
        dbSyncStatus: 0,
      )..category.target = catIncome,
      TransactionEntity(
        description: "بازگشت وجه اشتباه واریزی به فروشنده",
        amount: 25.00,
        date: now.subtract(const Duration(hours: 3)),
        dbType: 0,
        dbSyncStatus: 1,
      )..memo = "نیازمند پیگیری با حسابداری",
    ];

    for (final item in items) {
      _repository.insert(item);
    }
    OmniLogger.info(
        "Realistic scenario test data seeded into ObjectBox (${items.length} transactions, "
        "${categoryBox.count()} categories, ${vendorBox.count()} vendors).");
  }
}
