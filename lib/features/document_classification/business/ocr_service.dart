import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_confidence_calculator.dart';
import 'package:growth_pilot_ai/features/document_classification/domain/repositories/abstract_classifier_service.dart';

class OCRService {
  final _recognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<OmniResponse<OCRResult>> extractText(File imageFile) async {
    try {
      final classifier = DependencyInjection.get<AbstractClassifierService>();
      final classResult = await classifier.classifyDocument(imageFile);

      if (!classResult.isValid) {
        await HapticFeedback.heavyImpact();
        return OmniResponse<OCRResult>.error("Document not detected.");
      }

      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _recognizer.processImage(inputImage);

      return OmniResponse<OCRResult>.success(OCRResult(
        fullText: recognizedText.text ?? "",
        elements: const [],
        confidence: OcrConfidenceCalculator.calculate(recognizedText),
      ));
    } catch (e, stack) {
      assert(() {
        print("[Ahmad_Salem_Pour] [OCRService Critical]: $e\n$stack");
        return true;
      }());
      return OmniResponse<OCRResult>.error("فرآیند استخراج با خطا مواجه شد.");
    }
  }

  void dispose() => _recognizer.close();
}
