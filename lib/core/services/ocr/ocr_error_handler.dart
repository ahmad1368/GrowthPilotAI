import '../../models/ocr_result.dart';
import '../omni_logger.dart';

class OCRErrorHandler {
  static OCRResult? handle(Object e, StackTrace stack) {
    String techErr = e.toString().toLowerCase();
    String userMsg = 'خطای غیرمنتظره در پردازش تصویر.';

    if (techErr.contains('empty_result')) {
      userMsg = 'تصویر خوانا نیست. لطفاً با نور بهتر تلاش کنید.';
    } else if (techErr.contains('low_storage')) {
      userMsg = 'فضای حافظه کافی نیست.';
    }

    // ارسال به کنسول و اسنک‌بار از طریق لاگر متمرکز
    OmniLogger.error(
      title: "خطای پردازش",
      message: userMsg,
      widgetName: "OCRService",
      stackTrace: stack,
    );

    throw Exception(userMsg);
  }
}
