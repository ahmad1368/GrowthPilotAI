import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  TextRecognizer? _textRecognizer;

  void _initialize() {
    _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.latin);
  }

  Future<RecognizedText?> extractText(File imageFile) async {
    _initialize();
    final inputImage = InputImage.fromFilePath(imageFile.path);

    try {
      // اجرای آفلاین و امن با ML Kit
      return await _textRecognizer!.processImage(inputImage);
    } catch (e) {
      // به جای OmniLogger، خطا را لاگ می‌کنیم تا ورک‌فلو آن را مدیریت کند
      debugPrint("OCR Processing Error: $e");
      return null;
    }
  }

  void dispose() {
    _textRecognizer?.close();
    _textRecognizer = null;
  }
}
