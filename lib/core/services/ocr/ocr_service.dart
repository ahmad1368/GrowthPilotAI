// lib/core/services/ocr/ocr_service.dart

import 'dart:io';

import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

class OCRService {
  // به جای Future<OmniResponse<OCRResult>> فقط می‌نویسیم:
  OmniResult<OCRResult> extractText(File imageFile) async {
    try {
      // عملیات سنگین OCR...
      final result = OCRResult(fullText: "متن استخراج شده", elements: []);

      return OmniResponse.success(result);
    } catch (e) {
      return OmniResponse.error("خطا در پردازش تصویر: $e");
    }
  }

  /// آزادسازی منابع سرویس
  void dispose() {
    // ۱. بستن موتور پردازش (اگر از ML Kit یا Tesseract استفاده می‌کنید)
    // _textRecognizer.close();

    // ۲. پاک‌سازی کش‌های احتمالی یا متغیرهای موقت
    print("OCRService: Resources have been released.");
  }
}
