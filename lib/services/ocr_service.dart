import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:get/get.dart';

class OCRService extends GetxService {
  late TextRecognizer _textRecognizer;

  @override
  void onInit() {
    super.onInit();
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  }

  /// ۱. متد اصلی برای تبدیل تصویر به متن
  Future<RecognizedText> processImage(InputImage inputImage) async {
    try {
      return await _textRecognizer.processImage(inputImage);
    } catch (e) {
      print('OCR Error: $e');
      rethrow;
    }
  }

  /// ۲. متد استخراج مبلغ (اینجا اضافه شد)
  /// این متد خروجی متن خام را می‌گیرد و مبلغ نهایی را برمی‌گرداند
  double? extractTotalAmount(String text) {
    // رگکس برای پیدا کردن اعداد اعشاری (مثلاً 12.50 یا 1,200.99)
    // این الگو با فرمت‌های رایج در رسیدهای کانادایی سازگار است
    final amountRegex = RegExp(r'(\d{1,3}(?:[.,]\d{3})*[.,]\d{2})');

    final matches = amountRegex.allMatches(text);

    if (matches.isEmpty) return null;

    List<double> amounts = matches.map((m) {
      // حذف کاما برای تبدیل صحیح به double
      return double.parse(m.group(0)!.replaceAll(',', ''));
    }).toList();

    // مرتب‌سازی برای پیدا کردن بزرگترین عدد (معمولاً Total)
    amounts.sort();
    return amounts.isNotEmpty ? amounts.last : null;
  }

  /// ۳. متد کمکی برای اجرای کل فرآیند در یک مرحله
  Future<double?> getAmountFromImage(InputImage inputImage) async {
    final recognizedText = await processImage(inputImage);
    return extractTotalAmount(recognizedText.text);
  }

  @override
  void onClose() {
    _textRecognizer.close();
    super.onClose();
  }
}
