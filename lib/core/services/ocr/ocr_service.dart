import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';

class OCRService {
  // تعریف سرویس تشخیص متن گوگل مپ کیت
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  /// استخراج متن از فایل تصویر کراپ شده
  Future<OmniResponse<OCRResult>> extractText(File imageFile) async {
    try {
      // ۱. تبدیل فایل فیزیکی به InputImage مورد نیاز ML Kit
      final inputImage = InputImage.fromFile(imageFile);

      // ۲. شروع فرآیند پردازش تصویر توسط هوش مصنوعی
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);

      // ۳. لاگ کردن متن خام در محیط توسعه برای دیباگ راحت‌تر (Issue #266)
      // OmniLogger.info(
      //   title: "ML Kit OCR Raw Output",
      //   message:
      //       "متن خام استخراج شده: ${recognizedText.text.substring(0, recognizedText.text.length > 50 ? 50 : recognizedText.text.length)}...",
      //   widgetName: "OCRService",
      // );

      // ۴. ساخت مدل نتیجه با متغیرهای نام‌دار و پیش‌گیری از مقدار نال
      final result = OCRResult(
        fullText: recognizedText.text ?? "",
        elements: [],
        confidence: _calculateConfidence(recognizedText),
      );

      // ۵. بازگرداندن خروجی موفقیت‌آمیز در قالب کپسول OmniResponse
      return OmniResponse<OCRResult>.success(result);
    } catch (e, stack) {
      // ثبت خطاهای غیرمنتظره در لوگر پروژه
      OmniLogger.error(
        title: "خطا در استخراج متن",
        message: e,
        stackTrace: stack,
        widgetName: "OCRService",
      );
      return OmniResponse<OCRResult>.error(
          "فرآیند استخراج متن با خطا مواجه شد: $e");
    }
  }

  /// متد کمکی برای محاسبه میزان دقت و اطمینان متن خوانده شده
  double _calculateConfidence(RecognizedText recognizedText) {
    if (recognizedText.blocks.isEmpty) return 0.0;

    double totalConfidence = 0.0;
    int elementCount = 0;

    // پیمایش روی بلوک‌ها، خطوط و کلمات برای بدست آوردن میانگین دقت
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          // توجه: برخی نسخه‌های ML Kit فیلد confidence را مستقیماً روی المنت‌ها دارند
          // اگر پکیج شما این فیلد را ندارد، می‌توانید این متد را ساده‌تر کرده یا مقدار پیش‌فرض ۱.۰ بگذارید
          totalConfidence += (element.confidence ?? 1.0);
          elementCount++;
        }
      }
    }

    return elementCount > 0 ? (totalConfidence / elementCount) : 1.0;
  }

  /// آزادسازی منابع سخت‌افزاری در هنگام بسته شدن ورک‌فلو (مانند متد dispose در ScannerWorkflow)
  void dispose() {
    _textRecognizer.close();
    // OmniLogger.info(
    //   title: "OCR Service Closed",
    //   message: "منابع سخت‌افزاری TextRecognizer با موفقیت آزاد شدند.",
    //   widgetName: "OCRService",
    // );
  }
}
