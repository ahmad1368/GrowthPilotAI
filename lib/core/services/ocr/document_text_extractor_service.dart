import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_confidence_calculator.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_spatial_sorter.dart';

/// General-purpose OCR for scanned business documents (Issue #226/#227)
/// — reuses the same on-device Google ML Kit [TextRecognizer] as
/// [OCRService], but deliberately skips [OCRService]'s receipt/invoice
/// classifier gate: a scanned process document isn't a receipt, and
/// [OCRService.extractText] would wrongly reject it as "Document not
/// detected" (see PR notes).
class DocumentTextExtractorService {
  TextRecognizer? _textRecognizer;

  Future<OmniResponse<OCRResult>> extractText(File imageFile) async {
    if (kIsWeb) {
      return OmniResponse<OCRResult>.error(
          "Document OCR isn't available on web yet — please use the mobile app.");
    }
    try {
      _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText =
          await _textRecognizer!.processImage(InputImage.fromFile(imageFile));

      return OmniResponse<OCRResult>.success(OCRResult(
        fullText: recognizedText.text,
        elements: OCRSpatialSorter.sort(recognizedText),
        confidence: OcrConfidenceCalculator.calculate(recognizedText),
      ));
    } catch (e) {
      return OmniResponse<OCRResult>.error('Text extraction failed: $e');
    }
  }

  void dispose() => _textRecognizer?.close();
}
