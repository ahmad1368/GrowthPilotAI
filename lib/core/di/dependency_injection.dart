import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:growth_pilot_ai/features/document_classification/domain/repositories/abstract_classifier_service.dart';
import 'package:growth_pilot_ai/features/document_classification/data/services/tflite_classifier_service.dart';

class DependencyInjection {
  static final GetIt _locator = GetIt.instance;

  /// مقداردهی اولیه و ثبت تمام وابستگی‌های پروژه با تضمین عدم تداخل زمان راه‌اندازی
  static Future<void> init() async {
    try {
      // ۱. ابتدا سرویس نمونه عینی باید بدون قید و شرط ثبت شود تا GetIt خالی نماند
      final classifierService = TFliteClassifierService();
      _locator.registerSingleton<AbstractClassifierService>(classifierService);

      // ۲. لود کردن مدل هوش مصنوعی پس از اطمینان از ثبت نمونه
      await _locator<AbstractClassifierService>().loadModel();
    } catch (e, stack) {
      OmniLogger.error(
        title: "خطا در لایه تزریق وابستگی (DI)",
        message:
            "عدم موفقیت در ثبت یا لود مدل کلاسیفایر: $e | User: Ahmad_Salem_Pour",
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
