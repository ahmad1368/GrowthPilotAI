import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../utils/omni_logger.dart';
import '../../../widgets/common/omni_error_dialog.dart';

class OCRService {
  TextRecognizer? _textRecognizer;

  void _initialize() {
    // Lazy Initialization: فقط وقتی نیاز بود ساخته می‌شود
    _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.latin);
  }

  Future<RecognizedText?> extractText(File imageFile) async {
    _initialize();
    final inputImage = InputImage.fromFilePath(imageFile.path);

    try {
      // اجرای آفلاین و امن
      return await _textRecognizer!.processImage(inputImage);
    } catch (e) {
      OmniLogger.log(
        title: "خطای پردازش هوش مصنوعی",
        message: "متاسفانه امکان استخراج متن از این رسید وجود ندارد.",
        type: OmniMessageType.error,
        footer: "ML Error: $e",
      );
      return null;
    }
  }

  void dispose() {
    _textRecognizer?.close();
    _textRecognizer = null;
  }
}
