// lib/core/errors/failures.dart

abstract class OmniFailure {
  final String message;
  final int? statusCode;

  OmniFailure(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// خطاهای مربوط به سخت‌افزار (دوربین، سنسور، فایل)
class DeviceFailure extends OmniFailure {
  DeviceFailure(super.message) : super(statusCode: 400);
}

/// خطاهای مربوط به منطق پردازش و هوش مصنوعی
class ProcessorFailure extends OmniFailure {
  ProcessorFailure(super.message) : super(statusCode: 422);
}

/// خطاهای غیرمنتظره یا سمت سرور
class ServerFailure extends OmniFailure {
  ServerFailure(super.message) : super(statusCode: 500);
}

/// خطاهای مربوط به عدم دسترسی (Permissions)
class PermissionFailure extends OmniFailure {
  PermissionFailure(super.message) : super(statusCode: 403);
}
