import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import '../../models/ocr_result.dart';
import '../omni_logger.dart';

class OCRService {
  TextRecognizer? _textRecognizer;

  /// مقداردهی اولیه به صورت Lazy برای صرفه‌جویی در منابع
  void _initialize() {
    if (!kIsWeb) {
      _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.latin);
    }
  }

  /// متد اصلی استخراج متن با رویکرد امنیت داده و پایداری
  Future<OCRResult?> extractText(File imageFile) async {
    _initialize();

    try {
      String fullText = "";
      List<TextElementModel> elements = [];

      if (kIsWeb) {
        // --- بخش وب (Tesseract) ---
        fullText = await FlutterTesseractOcr.extractText(imageFile.path,
            language: 'eng');
      } else {
        // --- بخش موبایل (ML Kit) ---
        final inputImage = InputImage.fromFilePath(imageFile.path);
        final RecognizedText recognizedText =
            await _textRecognizer!.processImage(inputImage);

        fullText = recognizedText.text;

        // استخراج ساختاریافته مختصات کلمات
        for (TextBlock block in recognizedText.blocks) {
          for (TextLine line in block.lines) {
            for (TextElement element in line.elements) {
              elements.add(TextElementModel(
                text: element.text,
                boundingBox: element.boundingBox,
              ));
            }
          }
        }
      }

      // ۱. تست مسیر شکست: بررسی تصاویر خالی یا سیاه
      final String cleanText = fullText.trim();
      if (cleanText.isEmpty) {
        throw Exception('empty_result');
      }

      // ۲. امنیت حریم خصوصی: چاپ متن فقط در حالت Debug
      if (kDebugMode) {
        print("🛠 [OCR Debug] Length: ${cleanText.length} characters");
      }

      return OCRResult(
        fullText: cleanText,
        elements: elements,
      );
    } catch (e, stack) {
      return _handleOCRError(e, stack);
    }
  }

  /// مدیریت هوشمند خطا با حذف Footprint داده‌های حساس
  OCRResult? _handleOCRError(Object e, StackTrace stack) {
    String technicalError = e.toString().toLowerCase();
    String userMessage = 'خطای غیرمنتظره در پردازش تصویر.';

    // شناسایی خطاهای خاص
    if (technicalError.contains('empty_result')) {
      userMessage =
          'تصویر خوانا نیست یا متنی در آن یافت نشد. لطفاً با نور بهتر تلاش کنید.';
    } else if (technicalError.contains('low_storage') ||
        technicalError.contains('no space')) {
      userMessage = 'فضای حافظه کافی نیست. لطفاً کمی فضا خالی کنید.';
    } else if (technicalError.contains('model') &&
        technicalError.contains('not_found')) {
      userMessage = 'در حال آماده‌سازی هوش مصنوعی... لطفاً چند لحظه صبر کنید.';
    }

    // ۳. امنیت: لاگ کردن فقط نوع خطا، نه محتوای رسید
    OmniLogger.error(
      title: "OCR Operational Error",
      message:
          "OCR failed: ${e.runtimeType}", // متن حساس e را مستقیم لاگ نمی‌کنیم
      stackTrace: stack,
      widgetName: "OCRService",
    );

    throw Exception(userMessage);
  }

  /// آزادسازی منابع برای جلوگیری از Memory Leak
  void dispose() {
    _textRecognizer?.close();
    _textRecognizer = null;
    if (kDebugMode) print("♻️ OCR Resources Disposed.");
  }
}
