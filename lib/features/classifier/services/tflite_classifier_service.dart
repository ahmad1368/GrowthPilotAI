import 'package:image/image.dart' as img; // پکیج دستکاری پیکسل‌های تصویر
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/features/classifier/domain/enums/abstracts/base_classifier.dart';
import 'package:growth_pilot_ai/features/classifier/domain/enums/classifier_label.dart';
import 'package:growth_pilot_ai/features/classifier/domain/enums/models/classifier_request.dart';
import 'package:growth_pilot_ai/features/classifier/domain/enums/models/classifier_response_model.dart';

class TfliteClassifierService implements BaseClassifier {
  Interpreter? _interpreter;

  @override
  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset(
        'assets/models/mobilenet_v2_1.0_224_quant.tflite');
  }

  @override
  Future<OmniResponse<ClassifierResponseModel>> classify(
      ClassifierRequest request) async {
    if (_interpreter == null) return OmniResponse.error("مدل لود نشده است");

    try {
      // ۱. بررسی وجود فایل تصویر ورودی
      if (request.imageFile == null) {
        return OmniResponse.error("فایل تصویری یافت نشد");
      }

      // ۲. خواندن فایل از روی هارد دیسک و تبدیل به شیء تصویری در حافظه
      final bytes = await request.imageFile!.readAsBytes();
      final img.Image? originalImage = img.decodeImage(bytes);

      if (originalImage == null) {
        return OmniResponse.error("امکان دکود کردن تصویر وجود ندارد");
      }

      // ۳. ریسایز کردن تصویر به ابعاد دقیق مورد نیاز مدل (224x224)
      final img.Image resizedImage =
          img.copyResize(originalImage, width: 224, height: 224);

      // ۴. 🟢 استخراج پیکسل‌های واقعی تصویر و تزریق مستقیم به ماتریس ۴ بعدی [1, 224, 224, 3]
      final input = List.generate(
        1,
        (_) => List.generate(
          224,
          (y) => List.generate(224, (x) {
            final pixel = resizedImage.getPixel(x, y);
            // تزریق کانال‌های رنگی R, G, B به صورت عدد صحیح (0-255) برای مدل uint8
            return [pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt()];
          }),
        ),
      );

      // ۵. ساخت ماتریس خروجی منطبق با شبکه MobileNet
      final output = List.generate(1, (_) => List.filled(1001, 0));

      // ۶. اجرای مدل روی داده‌های واقعیِ تصویر دوربین
      _interpreter!.run(input, output);

      // ۷. از آنجا که مدل ۱۰۰۱ کلاس ImageNet عمومی را می‌شناسد، بالاترین مقدار احتمال را در کل آرایه پیدا می‌کنیم
      int maxScore = -1;
      int bestIndex = 0;
      for (int i = 0; i < output[0].length; i++) {
        if (output[0][i] > maxScore) {
          maxScore = output[0][i];
          bestIndex = i;
        }
      }

      // تبدیل مقدار ماکسیمم امتیاز (0 تا 255) به درصد اعشاری استاندارد (0.0 تا 1.0)
      final double confidence = maxScore / 255.0;

      // ۸. چون مدل عمومی است، موقتاً صحت سند را بر اساس فراتر رفتن از حد آستانه می‌سنجیم
      // (بعداً باید مشخص کنی کدام اندیس از این 1001 کلاس دقیقاً کد رسید مالی است)
      final isReceipt = confidence >= request.confidenceThreshold;
      final label =
          isReceipt ? ClassifierLabel.receipt : ClassifierLabel.background;

      return OmniResponse.success(ClassifierResponseModel(
        isValidDocument: isReceipt,
        confidence: confidence,
        detectedLabel: label,
      ));
    } catch (e) {
      return OmniResponse.error(
          "خطا در پیش‌پردازش و تحلیل تصویر: ${e.toString()}");
    }
  }

  @override
  void dispose() {
    _interpreter?.close();
  }
}
