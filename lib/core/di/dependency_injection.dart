import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/anonymizer_service.dart';
import 'package:growth_pilot_ai/business/intelligence_cache_sync_service.dart';
import 'package:growth_pilot_ai/business/local_benchmark_comparator_service.dart';
import 'package:growth_pilot_ai/core/data/entities/intelligence_cache_entry_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/intelligence_cache_repository.dart';
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
import 'package:growth_pilot_ai/business/sync_finalized_invoices_usecase.dart';
import 'package:growth_pilot_ai/core/interfaces/notification_channel.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_notification_channel.dart';
import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/core/interfaces/chat_gateway_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_chat_gateway_service.dart';
import 'package:growth_pilot_ai/core/interfaces/realtime_connection_registry.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_realtime_connection_registry.dart';
import 'package:growth_pilot_ai/core/interfaces/marketplace_adapter.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_ebay_adapter.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_amazon_adapter.dart';
import 'package:growth_pilot_ai/business/sync_listing_to_marketplaces_usecase.dart';
import 'package:growth_pilot_ai/core/interfaces/invoice_pdf_service.dart';
import 'package:growth_pilot_ai/core/data/services/local_invoice_pdf_service.dart';
import 'package:growth_pilot_ai/core/interfaces/payment_gateway.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_payment_gateway.dart';
import 'package:growth_pilot_ai/core/interfaces/exchange_rate_provider.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_exchange_rate_provider.dart';
import 'package:growth_pilot_ai/core/interfaces/speech_to_text_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_speech_to_text_service.dart';
import 'package:growth_pilot_ai/core/interfaces/social_auth_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_social_auth_service.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/data/datasources/secure_widget_layout_store.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_config_store.dart';
import 'package:growth_pilot_ai/core/data/datasources/secure_widget_config_store.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_export_service.dart';
import 'package:growth_pilot_ai/core/data/services/pdf_dashboard_export_service.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_template_store.dart';
import 'package:growth_pilot_ai/core/data/datasources/secure_dashboard_template_store.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';
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

      // ۸.۱.۱ اکسپورت فاکتورهای نهایی‌شده و وضعیت پرداخت به QuickBooks/Xero (Issue #149)
      _locator.registerLazySingleton<SyncFinalizedInvoicesUseCase>(
        () => SyncFinalizedInvoicesUseCase(_locator<AccountingExportService>()),
      );

      // ۸.۲ کانال دیسپچر نوتیفیکیشن (سوکت/FCM؛ Issue #71؛ فعلاً Mock)
      _locator.registerLazySingleton<NotificationChannel>(
        () => MockNotificationChannel(),
      );
      _locator.registerLazySingleton<DispatchNotificationUseCase>(
        () => DispatchNotificationUseCase(_locator<NotificationChannel>()),
      );

      // ۸.۳ رجیستری اتصال بلادرنگ مشترک بین چت/بازار/نوتیفیکیشن (Issue #130؛ Mock)
      _locator.registerLazySingleton<RealtimeConnectionRegistry>(
        () => MockRealtimeConnectionRegistry(),
      );

      // ۸.۴ گیت‌وی چت بازار عمده‌فروشی (Socket.io/NestJS؛ Issue #122؛ فعلاً Mock)
      _locator.registerLazySingleton<ChatGatewayService>(
        () => MockChatGatewayService(_locator<RealtimeConnectionRegistry>()),
      );

      // ۸.۵ آداپتورهای بازار عمده‌فروشی خارجی (eBay/Amazon؛ Issue #127؛ فعلاً Mock)
      _locator.registerLazySingleton<List<MarketplaceAdapter>>(
        () => [MockEbayAdapter(), MockAmazonAdapter()],
      );
      _locator.registerLazySingleton<SyncListingToMarketplacesUseCase>(
        () => SyncListingToMarketplacesUseCase(_locator<List<MarketplaceAdapter>>()),
      );

      // ۸.۶ سرویس تولید فاکتور PDF (GST/PST؛ Issue #146)
      _locator.registerLazySingleton<InvoicePdfService>(
        () => LocalInvoicePdfService(),
      );

      // ۸.۷ درگاه پرداخت (Stripe/Interac؛ Issue #147؛ فعلاً Mock — بدون داده کارت واقعی)
      _locator.registerLazySingleton<PaymentGateway>(
        () => MockPaymentGateway(),
      );

      // ۸.۸ سرویس نرخ ارز (Fixer.io/Stripe Rates؛ Issue #153؛ فعلاً Mock — نرخ ثابت)
      _locator.registerLazySingleton<ExchangeRateProvider>(
        () => MockExchangeRateProvider(),
      );

      // ۸.۹ سرویس تبدیل گفتار به متن (Whisper/on-device STT؛ Issue #154؛ فعلاً Mock)
      _locator.registerLazySingleton<SpeechToTextService>(
        () => MockSpeechToTextService(),
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

      // ۱۰.۳ سرویس اسمبل PDF برای اکسپورت داشبورد (Issue #117)
      _locator.registerLazySingleton<DashboardExportService>(
        () => PdfDashboardExportService(),
      );

      // ۱۰.۴ ذخیره‌سازی نسخه پشتیبان چیدمان پیش از اعمال قالب (Issue #118)
      _locator.registerLazySingleton<DashboardTemplateStore>(
        () => SecureDashboardTemplateStore(),
      );

      // ۱۰.۵ کش آفلاین بسته‌های هوش بخش‌بندی‌شده روی دستگاه، رمزنگاری‌شده در حالت سکون (Issue #105/#106)
      _locator.registerLazySingleton<IntelligenceCacheRepository>(
        () => IntelligenceCacheRepository(
            Get.find<ObjectBox>().store.box<IntelligenceCacheEntryEntity>()),
      );
      _locator.registerLazySingleton<IntelligenceCacheSyncService>(
        () => IntelligenceCacheSyncService(
          _locator<IntelligenceCacheRepository>(),
          FieldCipher(keyStorageKey: 'intelligence_cache_encryption_key'),
        ),
      );

      // ۱۰.۶ مقایسه‌گر آفلاین معیار بازار در برابر همتایان محلی رمزگشایی‌شده (Issue #107)
      _locator.registerLazySingleton<LocalBenchmarkComparatorService>(
        () => LocalBenchmarkComparatorService(
          _locator<IntelligenceCacheRepository>(),
          FieldCipher(keyStorageKey: 'intelligence_cache_encryption_key'),
        ),
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
