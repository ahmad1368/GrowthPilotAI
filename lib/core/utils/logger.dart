import 'dart:developer' as developer;

class OmniLogger {
  // فرمت‌کننده متمرکز و داخلی برای ساختار استاندارد لاگ‌ها
  static void _log(
    String level,
    String message,
    String worker, {
    String? service,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final time = DateTime.now().toIso8601String();
    final serviceTag = service != null ? "[$service]" : "";
    final logOutput =
        "[$time] $level $serviceTag: $message | Operator: $worker";

    developer.log(
      logOutput,
      name: 'OmniLogger',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// متد عمومی و استاندارد برای ثبت لاگ‌های عمومی با تعیین سطح (Level)
  static void log({
    required String message,
    required String worker,
    String? serviceName,
    String level = "INFO",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    _log(
      level.toUpperCase(),
      message,
      worker,
      service: serviceName,
      error: exception,
      stackTrace: stackTrace,
    );
  }

  /// ثبت لاگ‌های اطلاعاتی (تنها به متد استاندارد log پاس داده می‌شود)
  static void info({
    required String message,
    required String worker,
    String? serviceName,
  }) {
    log(
        message: message,
        worker: worker,
        serviceName: serviceName,
        level: "INFO");
  }

  /// ثبت هشدارهای سیستم
  static void warning({
    required String message,
    required String worker,
    String? serviceName,
  }) {
    log(
        message: message,
        worker: worker,
        serviceName: serviceName,
        level: "WARNING");
  }

  /// ثبت خطاهای کریتیکال به همراه Exception و StackTrace
  static void error({
    required String message,
    required String worker,
    String? serviceName,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    log(
      message: message,
      worker: worker,
      serviceName: serviceName,
      level: "ERROR",
      exception: exception,
      stackTrace: stackTrace,
    );
  }
}
