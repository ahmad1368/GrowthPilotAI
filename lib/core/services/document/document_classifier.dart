import '../../models/omni_response.dart';

class DocumentClassifier {
  // کلمات کلیدی برای تشخیص اولیه
  static const Map<String, List<String>> _systemTemplates = {
    'رسید خرید': ['total', 'amount', 'tax', 'visa', 'debit', 'receipt'],
    'سند تعمیرات': [
      'repair',
      'service',
      'mechanic',
      'labor',
      'parts',
      'warranty'
    ],
    'فاکتور فروش': ['invoice', 'bill to', 'ship to', 'quantity', 'unit price'],
  };

  /// تشخیص نوع سند بر اساس متن ورودی
  /// خروجی همیشه یک [OmniResponse] است که شامل نوع تشخیص داده شده در فیلد data می‌باشد.
  static OmniResponse<String> detect(String text) {
    // ۱. بررسی اعتبار ورودی
    if (text.trim().isEmpty) {
      return OmniResponse.error(
        "متن ورودی خالی است؛ امکان تشخیص نوع سند وجود ندارد.",
        statusCode: 400,
      );
    }

    final lowerText = text.toLowerCase();
    String detectedType = 'نامشخص';
    int maxMatches = 0;

    try {
      // ۲. اجرای منطق امتیازدهی بر اساس کلمات کلیدی
      _systemTemplates.forEach((type, keywords) {
        int matches = keywords.where((k) => lowerText.contains(k)).length;
        if (matches > maxMatches && matches > 0) {
          maxMatches = matches;
          detectedType = type;
        }
      });

      // ۳. بازگشت پاسخ موفق
      return OmniResponse.success(
        detectedType,
        message: detectedType == 'نامشخص'
            ? "الگوی مشابهی یافت نشد."
            : "نوع سند با موفقیت تشخیص داده شد.",
      );
    } catch (e) {
      // ۴. مدیریت خطاهای غیرمنتظره در حین پردازش
      return OmniResponse.error(
        "خطا در تحلیل هوشمند متن: ${e.toString()}",
        statusCode: 500,
      );
    }
  }
}
