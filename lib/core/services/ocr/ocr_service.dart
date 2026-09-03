import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_error_handler.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_spatial_sorter.dart';
import 'package:growth_pilot_ai/features/document_classification/domain/repositories/abstract_classifier_service.dart';
import 'ocr_block_mapper.dart';
import 'ocr_confidence_calculator.dart';
import 'ocr_image_size_reader.dart';

/// [Issue #21] Lazily creates the ML Kit [TextRecognizer] on first use so it
/// never opens on web, where the plugin has no implementation (Issue #19).
class OCRService {
  TextRecognizer? _textRecognizer;

  Future<OmniResponse<OCRResult>> extractText(File imageFile) async {
    if (kIsWeb) {
      return OmniResponse<OCRResult>.error(
          "Receipt scanning isn't available on web yet — please use the mobile app.");
    }
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

      _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.latin);
      final inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText =
          await _textRecognizer!.processImage(inputImage);
      final sortedBlocks = OCRSpatialSorter.sort(recognizedText);

      final result = OCRResult(
        fullText: recognizedText.text,
        elements: sortedBlocks,
        confidence: OcrConfidenceCalculator.calculate(recognizedText),
        blocks: OcrBlockMapper.map(sortedBlocks),
        imageSize: await OcrImageSizeReader.read(imageFile),
      );

      return OmniResponse<OCRResult>.success(result);
    } catch (e, stack) {
      // [Issue #21] OCRErrorHandler discriminates ML Kit-specific failures
      // (unreadable image, low storage) into a friendlier message; it logs
      // internally then rethrows, so we translate that back into an
      // OmniResponse here instead of letting it propagate.
      try {
        OCRErrorHandler.handle(e, stack);
      } catch (mapped) {
        return OmniResponse<OCRResult>.error(
            '$mapped'.replaceFirst('Exception: ', ''));
      }
      return OmniResponse<OCRResult>.error(
          "فرآیند استخراج متن با خطا مواجه شد: $e");
    }
  }

  void dispose() => _textRecognizer?.close();
}
