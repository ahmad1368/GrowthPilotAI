import 'dart:io';

import 'package:growth_pilot_ai/core/models/omni_response.dart';

class OCRResult {
  final String fullText;
  final List<dynamic> elements;
  final double? confidence;

  OCRResult({
    required this.fullText,
    required this.elements,
    this.confidence,
  });

  /// تبدیل مدل به JSON برای خروجی‌های استاندارد OmniResponse
  Map<String, dynamic> toJson() {
    return {
      'fullText': fullText,
      'elements': elements,
      'confidence': confidence,
    };
  }

  /// ساخت مدل از روی JSON (برای زمانی که داده از API یا کش می‌آید)
  factory OCRResult.fromJson(Map<String, dynamic> json) {
    return OCRResult(
      fullText: json['fullText'] ?? '',
      elements: json['elements'] ?? [],
      confidence: (json['confidence'] as num?)?.toDouble(),
    );
  }

  Future<OmniResponse<OCRResult>> extractText(File imageFile) async {
    try {
      // منطق OCR شما در اینجا...
      // فرض کنیم خروجی خام استخراج شده:
      final String rawText = "متن تست";
      final List<dynamic> rawElements = [];

      final result = OCRResult(
        fullText: rawText,
        elements: rawElements,
        confidence: 0.95, // مقدار فرضی
      );

      // ۲. اجرای Validation بلافاصله پس از ساخت آبجکت
      final validation = result.validate();
      if (!validation.success) {
        // بازگرداندن خطای ولیدیشن در قالب استاندارد پروژه
        return OmniResponse.error(
            validation.message ?? "خطای اعتبار سنجی داده");
      }

      return OmniResponse.success(result);
    } catch (e) {
      return OmniResponse.error("خطای سیستمی: $e");
    }
  }

  /// کپی کردن آبجکت با مقادیر جدید بدون تغییر در دیتای اصلی
  OCRResult copyWith({
    String? fullText,
    List<dynamic>? elements,
    double? confidence,
  }) {
    return OCRResult(
      fullText: fullText ?? this.fullText,
      elements: elements ?? this.elements,
      confidence: confidence ?? this.confidence,
    );
  }

  /// آزادسازی منابع برای جلوگیری از نشت حافظه
  void dispose() {
    elements.clear();
    // در صورتی که المنت‌ها نیاز به بستن کنترلر دارند، اینجا اضافه شود
  }

  /// بررسی معتبر بودن دیتای استخراج شده
  OmniResponse<bool> validate() {
    if (fullText.trim().isEmpty) {
      return OmniResponse.error("متن استخراج شده خالی است.");
    }
    if (fullText.length < 5) {
      return OmniResponse.error(
          "متن استخراج شده بسیار کوتاه و غیرقابل اعتماد است.");
    }
    if (confidence != null && confidence! < 0.5) {
      return OmniResponse.error(
          "دقت تشخیص پایین‌تر از حد مجاز است (${(confidence! * 100).toInt()}%).");
    }
    return OmniResponse.success(true);
  }
}
