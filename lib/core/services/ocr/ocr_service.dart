import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter_tesseract_ocr/android_ios.dart';
import '../../models/ocr_result.dart';
import '../omni_logger.dart';
import 'ocr_spatial_sorter.dart'; // منطق مرتب‌سازی (Issue #23)
import 'ocr_error_handler.dart'; // منطق مدیریت خطا

class OCRService {
  TextRecognizer? _textRecognizer;

  void _initialize() {
    if (!kIsWeb) {
      _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.latin);
    }
  }

  Future<OCRResult?> extractText(File imageFile) async {
    _initialize();
    try {
      if (kIsWeb) {
        final text = await FlutterTesseractOcr.extractText(imageFile.path,
            language: 'eng');
        return OCRResult(fullText: text, elements: []);
      }

      final inputImage = InputImage.fromFilePath(imageFile.path);
      final rawData = await _textRecognizer!.processImage(inputImage);

      // --- اعمال Issue #23: مرتب‌سازی فضایی بلاک‌ها ---
      final sortedBlocks = OCRSpatialSorter.sort(rawData);

      List<TextElementModel> elements = [];
      StringBuffer fullTextBuffer = StringBuffer();

      for (var block in sortedBlocks) {
        fullTextBuffer.writeln(block.text);
        for (var line in block.lines) {
          for (var element in line.elements) {
            elements.add(TextElementModel(
              text: element.text,
              boundingBox: element.boundingBox,
            ));
          }
        }
      }

      final cleanText = fullTextBuffer.toString().trim();
      if (cleanText.isEmpty) throw Exception('empty_result');

      return OCRResult(fullText: cleanText, elements: elements);
    } catch (e, stack) {
      return OCRErrorHandler.handle(e, stack);
    }
  }

  void dispose() {
    _textRecognizer?.close();
    _textRecognizer = null;
  }
}
