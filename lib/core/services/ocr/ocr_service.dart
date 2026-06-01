import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/features/document_classification/domain/repositories/abstract_classifier_service.dart';
import 'ocr_confidence_calculator.dart';

class OCRService {
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  Future<OmniResponse<OCRResult>> extractText(File imageFile) async {
    try {
      final classifier = DependencyInjection.get<AbstractClassifierService>();
      final classificationResult = await classifier.classifyDocument(imageFile);

      if (!classificationResult.isValid) {
        await HapticFeedback.heavyImpact();
        OmniLogger.error(
          title: "عدم تایید اصالت سند",
          message:
              "تصویر ورودی فاکتور یا رسید معتبر نیست. کانفیدنس: ${classificationResult.confidence} | User: Ahmad_Salem_Pour",
          widgetName: "OCRService",
        );
        return OmniResponse<OCRResult>.error(
            "Document not detected. Please align the receipt.");
      }

      final inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(inputImage);

      final result = OCRResult(
        fullText: recognizedText.text ?? "",
        elements: [],
        confidence: OcrConfidenceCalculator.calculate(recognizedText),
      );

      return OmniResponse<OCRResult>.success(result);
    } catch (e, stack) {
      OmniLogger.error(
        title: "خطا در استخراج متن یا کلاسیفایر",
        message: "خطای سیستمی: $e | User: Ahmad_Salem_Pour",
        stackTrace: stack,
        widgetName: "OCRService",
      );
      return OmniResponse<OCRResult>.error(
          "فرآیند استخراج متن با خطا مواجه شد: $e");
    }
  }

  void dispose() => _textRecognizer.close();
}
