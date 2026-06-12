import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/features/document_classification/domain/repositories/abstract_classifier_service.dart';
import 'package:growth_pilot_ai/features/document_classification/data/services/tflite_classifier_service.dart';

class MockTransactionRepository implements TransactionRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  /// مقداردهی اولیه و ثبت تمام وابستگی‌های پروژه
  static Future<void> init() async {
    try {
      final classifierService = TFliteClassifierService();
      _locator.registerSingleton<AbstractClassifierService>(classifierService);

      _locator.registerLazySingleton<TransactionRepository>(
        () => MockTransactionRepository(),
      );

      await _locator<AbstractClassifierService>().loadModel();
    } catch (e, stack) {
      // ثبت خطاها به صورت محلی تا زمان بازنویسی لایه جامع لاگ
      assert(() {
        print("DI Error [Ahmad_Salem_Pour] [2026-06-02]: $e\n$stack");
        return true;
      }());
    }
  }

  /// متد عمومی برای دریافت نمونه (Instance) سرویس‌ها در سراسر برنامه
  static T get<T extends Object>() {
    return _locator<T>();
  }
}
