import 'package:logger/logger.dart';
import 'package:growth_pilot_ai/business/persist_omni_log_entry.dart';
import 'package:growth_pilot_ai/core/enum/omni_log_level.dart';

class OmniLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static void info(String message) {
    _logger.i(message);
    PersistOmniLogEntry.call(OmniLogLevel.info, 'Info', message);
  }

  static void warning(String message) {
    _logger.w(message);
    PersistOmniLogEntry.call(OmniLogLevel.warning, 'Warning', message);
  }

  /// ثبت متمرکز خطاها همراه با مشخصات دقیق کاربر، ویجت و سیستم ارور
  static void error({
    required String title,
    required String widgetName,
    dynamic message,
    StackTrace? stackTrace,
    String userId = "Ahmad_Salem_Pour",
  }) {
    // ترکیب اطلاعات ساختاریافته برای نمایش یکپارچه در کنسول و دیباگ
    final structuredMessage =
        " User: $userId | Widget: $widgetName | Details: $message";

    _logger.e(
      title,
      error: structuredMessage,
      stackTrace: stackTrace,
    );
    PersistOmniLogEntry.call(OmniLogLevel.error, title, structuredMessage, stackTrace);
  }
}
