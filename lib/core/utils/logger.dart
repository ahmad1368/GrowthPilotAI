import 'package:logger/logger.dart';

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

  static void info(String message) => _logger.i(message);

  static void warning(String message) => _logger.w(message);

  // دقت کنید: نام پارامترهای ورودی باید دقیقاً با چیزی که به _logger.e پاس می‌دهیم یکی باشد
  static void error({
    required String title,
    dynamic message, // نام پارامتر: message
    StackTrace? stackTrace, // نام پارامتر: stackTrace
  }) {
    // اینجا از همان نام‌هایی که در خطوط بالا تعریف کردیم استفاده می‌کنیم
    _logger.e(
      title,
      error: message, // مقدار message به پارامتر errorِ پکیج پاس داده می‌شود
      stackTrace:
          stackTrace, // مقدار stackTrace به پارامتر stackTraceِ پکیج پاس داده می‌شود
    );
  }
}
