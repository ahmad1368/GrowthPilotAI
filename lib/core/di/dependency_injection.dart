import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/anonymizer_service.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/business/csv_export_strategy.dart';
import 'package:growth_pilot_ai/business/fetch_transactions_usecase.dart';
import 'package:growth_pilot_ai/business/sync_transactions_usecase.dart';
import 'package:growth_pilot_ai/core/interfaces/export_strategy.dart';
import 'package:growth_pilot_ai/core/interfaces/transaction_fetch_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_transaction_fetch_service.dart';
import 'package:growth_pilot_ai/core/interfaces/accounting_auth_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_accounting_auth_service.dart';
import 'package:growth_pilot_ai/core/interfaces/bank_link_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_bank_link_service.dart';
import 'package:growth_pilot_ai/core/interfaces/accounting_export_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_accounting_export_service.dart';
import 'package:growth_pilot_ai/business/sync_confirmed_transactions_usecase.dart';
import 'package:growth_pilot_ai/core/interfaces/notification_channel.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_notification_channel.dart';
import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/core/interfaces/social_auth_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_social_auth_service.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/data/datasources/secure_widget_layout_store.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_config_store.dart';
import 'package:growth_pilot_ai/core/data/datasources/secure_widget_config_store.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/models/sync_config.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:growth_pilot_ai/features/document_classification/domain/repositories/abstract_classifier_service.dart';
import 'package:growth_pilot_ai/features/document_classification/data/services/tflite_classifier_service.dart';

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  /// مقداردهی اولیه و ثبت تمام وابستگی‌های پروژه با تضمین عدم تداخل زمان راه‌اندازی
  static Future<void> init() async {
    try {
      // ۱. ثبت سرویس نمونه عینی TFLite برای دسترسی لایه اسکنر
      final classifierService = TFliteClassifierService();
      _locator.registerSingleton<AbstractClassifierService>(classifierService);

      // ۲. ریپازیتوری واقعی تراکنش‌ها (Issue #27؛ قبلاً Mock بود و
      // saveTransaction را غیرفعال نگه می‌داشت). Store پیش از این متد در
      // main.dart با Get.put<ObjectBox> ثبت شده است.
      _locator.registerLazySingleton<TransactionRepository>(
        () => TransactionRepository(
            Get.find<ObjectBox>().store.box<TransactionEntity>()),
      );

      // ۳. ثبت سرویس احراز هویت اجتماعی (فعلاً Mock تا Firebase واقعی آماده شود)
      _locator.registerLazySingleton<SocialAuthService>(
        () => MockSocialAuthService(),
      );

      // ۴. ثبت منبع همگام‌سازی ابری (بازگردانی؛ یوزکیس دلتا به آن وابسته است)
      _locator.registerLazySingleton<RemoteSyncDataSource>(
        () => MockRemoteSyncDataSource(SyncConfig.fromEnvironment()),
      );

      // ۵. یوزکیس همگام‌سازی دلتا (وابسته به منبع همگام‌سازی بالا)
      _locator.registerLazySingleton<SyncTransactionsUseCase>(
        () => SyncTransactionsUseCase(_locator<RemoteSyncDataSource>()),
      );

      // ۶. سرویس واکشی خودکار تراکنش‌ها (Plaid) + یوزکیس حلقه‌ی واکشی
      _locator.registerLazySingleton<TransactionFetchService>(
        () => MockTransactionFetchService(),
      );
      _locator.registerLazySingleton<FetchTransactionsUseCase>(
        () => FetchTransactionsUseCase(_locator<TransactionFetchService>()),
      );

      // ۷. ثبت سرویس اتصال بانکی Plaid (بازگردانی؛ فعلاً Mock)
      _locator.registerLazySingleton<BankLinkService>(
        () => MockBankLinkService(),
      );

      // ۸. ثبت سرویس OAuth حساب‌داری (QuickBooks/Xero؛ فعلاً Mock)
      _locator.registerLazySingleton<AccountingAuthService>(
        () => MockAccountingAuthService(),
      );

      // ۸.۱ سرویس اکسپورت تراکنش‌های تاییدشده به QuickBooks/Xero (Issue #59؛ فعلاً Mock)
      _locator.registerLazySingleton<AccountingExportService>(
        () => MockAccountingExportService(),
      );
      _locator.registerLazySingleton<SyncConfirmedTransactionsUseCase>(
        () => SyncConfirmedTransactionsUseCase(
            _locator<AccountingExportService>()),
      );

      // ۸.۲ کانال دیسپچر نوتیفیکیشن (سوکت/FCM؛ Issue #71؛ فعلاً Mock)
      _locator.registerLazySingleton<NotificationChannel>(
        () => MockNotificationChannel(),
      );
      _locator.registerLazySingleton<DispatchNotificationUseCase>(
        () => DispatchNotificationUseCase(_locator<NotificationChannel>()),
      );

      // ۹. استراتژی خروجی داده (فعلاً CSV؛ Excel/PDF بعداً اضافه می‌شوند)
      _locator.registerLazySingleton<ExportStrategy>(
        () => CsvExportStrategy(),
      );

      // ۱۰. سرویس ناشناس‌سازی داده پیش از ذخیره ابری (تحلیل بازار)
      _locator.registerLazySingleton<AnonymizerService>(
        () => AnonymizerService(),
      );

      // ۱۰.۱ ذخیره‌سازی چیدمان ویجت‌های داشبورد (Issue #114؛ روی SecureStorageService واقعی)
      _locator.registerLazySingleton<WidgetLayoutStore>(
        () => SecureWidgetLayoutStore(),
      );

      // ۱۰.۲ ذخیره‌سازی تنظیمات هر ویجت (Issue #115؛ روی SecureStorageService واقعی)
      _locator.registerLazySingleton<WidgetConfigStore>(
        () => SecureWidgetConfigStore(),
      );

      // ۹. لود کردن مدل هوش مصنوعی پس از اطمینان از ثبت نمونه
      // [Issue #25] tflite_flutter has no web implementation — OCR itself
      // already refuses to run on web (see OCRService.extractText), so
      // skip the model load there instead of failing into the catch below
      // on every page load.
      if (!kIsWeb) {
        await _locator<AbstractClassifierService>().loadModel();
      }
    } catch (e, stack) {
      OmniLogger.error(
        title: "خطا در لایه تزریق وابستگی (DI)",
        message: "عدم موفقیت در ثبت یا لود وابستگی‌ها: $e",
        stackTrace: stack,
        widgetName: "DependencyInjection",
      );
    }
  }

  /// متد عمومی برای دریافت نمونه (Instance) سرویس‌ها در سراسر برنامه
  static T get<T extends Object>() {
    return _locator<T>();
  }
}
