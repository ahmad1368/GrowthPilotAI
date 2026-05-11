import 'dart:developer';
import '../data/objectbox_provider.dart';
import '../models/error_log.dart';
import '../../main.dart'; // برای دسترسی به متغیر سراسری objectbox

class OmniLogger {
  /// متد اصلی برای ثبت خطاها از سراسر برنامه
  static void error({
    required String title,
    required dynamic message,
    StackTrace? stackTrace,
    String? widgetName,
  }) {
    final String errorMsg = message.toString();
    final DateTime now = DateTime.now();

    // ۱. چاپ در کنسول (فقط در حالت Debug)
    log('❌ [$title] در ویجت ($widgetName): $errorMsg');

    // ۲. ذخیره در دیتابیس محلی (ObjectBox)
    _saveToLocalDatabase(
      title: title,
      message: errorMsg,
      stackTrace: stackTrace.toString(),
      widgetName: widgetName ?? 'Global',
      time: now,
    );

    // ۳. ارسال به سیستم‌های آنلاین (مثل Sentry یا Crashlytics)
    _sendToOnlineServices(title, errorMsg, stackTrace, widgetName);
  }

  static void _saveToLocalDatabase({
    required String title,
    required String message,
    required String stackTrace,
    required String widgetName,
    required DateTime time,
  }) {
    try {
      final logEntry = ErrorLog(
        title: title,
        message: message,
        stackTrace: stackTrace,
        timestamp: time,
        widgetName: widgetName,
      );
      // استفاده از باکس مخصوص ارورها در ObjectBox
      objectbox.store.box<ErrorLog>().put(logEntry);
    } catch (e) {
      log('Critical: Failed to save error log to ObjectBox: $e');
    }
  }

  static void _sendToOnlineServices(
    String title,
    String message,
    StackTrace? stack,
    String? widget,
  ) {
    // اینجا در آینده کد Sentry یا Firebase را قرار می‌دهیم
    // مثال: Sentry.captureException(message, stackTrace: stack);
  }
}
