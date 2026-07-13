import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/fetch_transactions_usecase.dart';
import 'package:growth_pilot_ai/business/sync_transactions_usecase.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_transaction_fetch_service.dart';
import 'package:growth_pilot_ai/core/interfaces/transaction_fetch_service.dart';
import 'package:growth_pilot_ai/core/interfaces/social_auth_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_social_auth_service.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/interfaces/remote_sync_data_source.dart';
import 'package:growth_pilot_ai/core/models/sync_config.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:growth_pilot_ai/features/document_classification/domain/repositories/abstract_classifier_service.dart';
import 'package:growth_pilot_ai/features/document_classification/data/services/tflite_classifier_service.dart';

// یک پیاده‌سازی سبک موقت برای باز شدن فوری صفحه بدون ارور لایه دیتا
class MockTransactionRepository implements TransactionRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  /// مقداردهی اولیه و ثبت تمام وابستگی‌های پروژه با تضمین عدم تداخل زمان راه‌اندازی
  static Future<void> init() async {
    try {
      // ۱. ثبت سرویس نمونه عینی TFLite برای دسترسی لایه اسکنر
      final classifierService = TFliteClassifierService();
      _locator.registerSingleton<AbstractClassifierService>(classifierService);

      // ۲. تزریق مستقیم قرارداد برای باز شدن کادر ویرایش بدون خطای کامپایل
      _locator.registerLazySingleton<TransactionRepository>(
        () => MockTransactionRepository(),
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

      // ۷. لود کردن مدل هوش مصنوعی پس از اطمینان از ثبت نمونه
      await _locator<AbstractClassifierService>().loadModel();
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
