import 'package:growth_pilot_ai/core/models/ocr_result.dart';

class OCRErrorHandler {
  /// مدیریت خطاهای لایه پردازش تصویر و نگاشت به استثناهای استاندارد کاربر
  static OCRResult? handle(Object e, StackTrace stack) {
    final String techErr = e.toString().toLowerCase();
    String userMsg = 'خطای غیرمنتظره در پردازش تصویر.';

    if (techErr.contains('empty_result')) {
      userMsg = 'تصویر خوانا نیست. لطفاً با نور بهتر تلاش کنید.';
    } else if (techErr.contains('low_storage')) {
      userMsg = 'فضای حافظه کافی نیست.';
    }

    // ثبت خطا در سطح محلی و توسعه با برچسب توسعه‌دهنده و StackTrace
    assert(() {
      print(
          "[Ahmad_Salem_Pour] [OCRService Error]: $userMsg | Tech: $techErr\n$stack");
      return true;
    }());

    throw Exception(userMsg);
  }
}
