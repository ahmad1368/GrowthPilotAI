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
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
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
  ///
  /// [userId] used to default to a specific developer's real name
  /// (Issue #165) — meaning every error logged anywhere in the app,
  /// unless a caller explicitly overrode it, was mis-tagged with one
  /// person's identity instead of whoever actually triggered it.
  static void error({
    required String title,
    required String widgetName,
    dynamic message,
    StackTrace? stackTrace,
    String userId = 'local-user',
  }) {
    // ترکیب اطلاعات ساختاریافته برای نمایش یکپارچه در کنسول و دیباگ
    final structuredMessage =
        " User: $userId | Widget: $widgetName | Details: $message";

    _logger.e(
      title,
      error: structuredMessage,
      stackTrace: stackTrace,
    );
    PersistOmniLogEntry.call(OmniLogLevel.error, title, structuredMessage, stackTrace, userId);
  }
}
