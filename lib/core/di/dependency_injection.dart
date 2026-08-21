import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/anonymizer_service.dart';
import 'package:growth_pilot_ai/business/intelligence_cache_sync_service.dart';
import 'package:growth_pilot_ai/business/local_benchmark_comparator_service.dart';
import 'package:growth_pilot_ai/business/insight_trigger_service.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/notification_conversion_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/notification_conversion_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/embedding_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/project_metrics_snapshot_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/project_metrics_snapshot_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_goal_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceable_requirement_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_test_case_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_history_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/suggested_link_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/suggested_link_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/branding_settings_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/branding_settings_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/prompt_click_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/prompt_click_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/ai_response_feedback_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/ai_response_feedback_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/ai_monitor_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/ai_monitor_event_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/forecast_accuracy_report_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/forecast_accuracy_report_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_importance_report_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/feature_importance_report_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/action_impact_item_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/action_impact_item_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/business_contact_visibility_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_contact_visibility_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/legal_consent_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/legal_consent_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/consent_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/consent_log_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/microphone_consent_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/microphone_consent_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/local_usage_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/local_usage_event_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/security_audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/security_audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/security_incident_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/security_incident_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/breach_notification_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/breach_notification_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/embedding_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/embedding_service.dart';
import 'package:growth_pilot_ai/core/services/mock_embedding_service.dart';
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

      // ۸.۱.۲ دیتابیس محلی بردار برای RAG (Issue #198؛ سرویس امبدینگ فعلاً Mock)
      _locator.registerLazySingleton<EmbeddingRepository>(
        () => EmbeddingRepository(Get.find<ObjectBox>().store.box<EmbeddingEntity>()),
      );
      _locator.registerLazySingleton<EmbeddingService>(
        () => MockEmbeddingService(),
      );

      // ۸.۱.۳ ردیابی فراوانی کلیک روی پرامپت‌های پیشنهادی چت هوش مصنوعی (Issue #201)
      _locator.registerLazySingleton<PromptClickRepository>(
        () => PromptClickRepository(Get.find<ObjectBox>().store.box<PromptClickEntity>()),
      );

      // ۸.۱.۴ بازخورد کاربر (لایک/دیسلایک) روی پاسخ‌های چت هوش مصنوعی (Issue #209)
      _locator.registerLazySingleton<AiResponseFeedbackRepository>(
        () => AiResponseFeedbackRepository(
            Get.find<ObjectBox>().store.box<AiResponseFeedbackEntity>()),
      );

      // ۸.۱.۵ رصد کارایی و توهم مدل هوش مصنوعی محلی (Issue #210)
      _locator.registerLazySingleton<AiMonitorEventRepository>(
        () => AiMonitorEventRepository(Get.find<ObjectBox>().store.box<AiMonitorEventEntity>()),
      );

      // ۸.۱.۶ ثبت خطای پیش‌بینی هزینه (MAPE) در پایان هر دوره صورتحساب (Issue #207)
      _locator.registerLazySingleton<ForecastAccuracyReportRepository>(
        () => ForecastAccuracyReportRepository(
            Get.find<ObjectBox>().store.box<ForecastAccuracyReportEntity>()),
      );

      // ۸.۱.۷ تحلیل اهمیت ویژگی‌ها (وزن دسته‌های هزینه) در مدل پیش‌بینی (Issue #208)
      _locator.registerLazySingleton<FeatureImportanceReportRepository>(
        () => FeatureImportanceReportRepository(
            Get.find<ObjectBox>().store.box<FeatureImportanceReportEntity>()),
      );

      // ۸.۱.۸ ردیاب اثر اقدامات (Action-Impact Tracker) روی توصیه‌های هوش مصنوعی (Issue #260)
      _locator.registerLazySingleton<ActionImpactItemRepository>(
        () => ActionImpactItemRepository(
            Get.find<ObjectBox>().store.box<ActionImpactItemEntity>()),
      );

      // ۸.۱.۹ تنظیمات نمایش‌پذیری فیلدهای تماس کسب‌وکار (Issue #218)
      _locator.registerLazySingleton<BusinessContactVisibilityRepository>(
        () => BusinessContactVisibilityRepository(
            Get.find<ObjectBox>().store.box<BusinessContactVisibilityEntity>()),
      );

      // ۸.۱.۱۰ وضعیت پذیرش قوانین و سیاست حریم خصوصی (Issue #215)
      _locator.registerLazySingleton<LegalConsentRepository>(
        () => LegalConsentRepository(Get.find<ObjectBox>().store.box<LegalConsentEntity>()),
      );
      _locator.registerLazySingleton<ConsentLogRepository>(
        () => ConsentLogRepository(Get.find<ObjectBox>().store.box<ConsentLogEntity>()),
      );

      // ۸.۱.۱۱ سوییچ نمایشی رضایت پایش میکروفون (Mock/UI-only؛ Issue #540)
      _locator.registerLazySingleton<MicrophoneConsentRepository>(
        () => MicrophoneConsentRepository(
            Get.find<ObjectBox>().store.box<MicrophoneConsentEntity>()),
      );

      // ۸.۱.۱۲ لاگ محلی رویدادهای استفاده درون‌برنامه‌ای (Issue #539)
      _locator.registerLazySingleton<LocalUsageEventRepository>(
        () => LocalUsageEventRepository(
            Get.find<ObjectBox>().store.box<LocalUsageEventEntity>()),
      );

      // ۸.۱.۱۳ لاگ ممیزی امنیتی برای اقدامات حساس (WORM؛ Issue #186)
      _locator.registerLazySingleton<SecurityAuditLogRepository>(
        () => SecurityAuditLogRepository(
            Get.find<ObjectBox>().store.box<SecurityAuditLogEntity>()),
      );

      // ۸.۱.۱۴ لاگ حوادث امنیتی و اعلان نقض داده (PIPEDA؛ Issue #187)
      _locator.registerLazySingleton<SecurityIncidentRepository>(
        () => SecurityIncidentRepository(
            Get.find<ObjectBox>().store.box<SecurityIncidentEntity>()),
      );
      _locator.registerLazySingleton<BreachNotificationLogRepository>(
        () => BreachNotificationLogRepository(
            Get.find<ObjectBox>().store.box<BreachNotificationLogEntity>()),
      );

      // ۸.۱.۱۵ ماندگاری آفلاین KPI Dashboard (Issue #237؛ ObjectBox به‌جای Hive)
      _locator.registerLazySingleton<ProjectMetricsSnapshotRepository>(
        () => ProjectMetricsSnapshotRepository(
            Get.find<ObjectBox>().store.box<ProjectMetricsSnapshotEntity>()),
      );

      // ۸.۱.۱۶ اسکیمای ردیابی الزامات + لاگ ممیزی (Issue #238)
      _locator.registerLazySingleton<BusinessGoalRepository>(
        () => BusinessGoalRepository(Get.find<ObjectBox>().store.box<BusinessGoalEntity>()),
      );
      _locator.registerLazySingleton<TraceableRequirementRepository>(
        () => TraceableRequirementRepository(
            Get.find<ObjectBox>().store.box<TraceableRequirementEntity>()),
      );
      _locator.registerLazySingleton<TraceabilityTestCaseRepository>(
        () => TraceabilityTestCaseRepository(
            Get.find<ObjectBox>().store.box<TraceabilityTestCaseEntity>()),
      );
      _locator.registerLazySingleton<TraceabilityLinkRepository>(
        () => TraceabilityLinkRepository(
            Get.find<ObjectBox>().store.box<GoalRequirementLinkEntity>(),
            Get.find<ObjectBox>().store.box<RequirementTestCaseLinkEntity>()),
      );
      _locator.registerLazySingleton<RequirementHistoryRepository>(
        () => RequirementHistoryRepository(
            Get.find<ObjectBox>().store.box<RequirementHistoryEntity>()),
      );

      // ۸.۱.۱۷ لینک‌های پیشنهادی هوش مصنوعی برای ماتریس ردیابی (Issue #244)
      _locator.registerLazySingleton<SuggestedLinkRepository>(
        () => SuggestedLinkRepository(Get.find<ObjectBox>().store.box<SuggestedLinkEntity>()),
      );

      // ۸.۱.۱۸ لاگ رویدادهای Export/Share (Issue #250)
      _locator.registerLazySingleton<ExportEventRepository>(
        () => ExportEventRepository(Get.find<ObjectBox>().store.box<ExportEventEntity>()),
      );

      // ۸.۱.۱۹ تنظیمات برندینگ محلی برای هدر PDF (Issue #257)
      _locator.registerLazySingleton<BrandingSettingsRepository>(
        () => BrandingSettingsRepository(Get.find<ObjectBox>().store.box<BrandingSettingsEntity>()),
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

      // ۱۰.۷ محرک دوره‌ای بینش‌های محلی («خریدار شخصی» آفلاین، Issue #108)
      _locator.registerLazySingleton<InboxNotificationRepository>(
        () => InboxNotificationRepository(Get.find<ObjectBox>().store.box<InboxNotificationEntity>()),
      );

      // ۱۰.۸ ردیابی تبدیل اعلان‌ها (Issue #161)
      _locator.registerLazySingleton<NotificationConversionRepository>(
        () => NotificationConversionRepository(
            Get.find<ObjectBox>().store.box<NotificationConversionEventEntity>()),
      );
      _locator.registerLazySingleton<InsightTriggerService>(
        () => InsightTriggerService(
          _locator<IntelligenceCacheRepository>(),
          _locator<InboxNotificationRepository>(),
          FieldCipher(keyStorageKey: 'intelligence_cache_encryption_key'),
          _locator<DispatchNotificationUseCase>(),
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
