// lib/features/document_classification/data/models/classification_response.dart
import '../../domain/entities/document_type.dart';
import '../../domain/entities/omni_classification_result.dart';

class ClassificationResponse {
  /// تبدیل خروجی ماتریکس TFLite به مدل خروجی استاندارد دامین با تحلیل ایندکس‌های عمومی
  static OmniClassificationResult fromMatrix(List<dynamic> outputMatrix) {
    final List<double> probabilities = (outputMatrix[0] as List)
        .map((element) => (element as num).toDouble())
        .toList();

    double maxConfidenceRaw = 0;
    int maxIndex = 0;

    for (int i = 0; i < probabilities.length; i++) {
      if (probabilities[i] > maxConfidenceRaw) {
        maxConfidenceRaw = probabilities[i];
        maxIndex = i;
      }
    }

    // تبدیل مقدار خروجی کوانتیزه (0 تا 255) به درصد اعشاری استاندارد فلاتر (0.0 تا 1.0)
    final double normalizedConfidence = maxConfidenceRaw / 255.0;

    // اگر مدل کلاس‌های مربوط به ساختار کاغذ/مستندات عمومی (رنج 900 تا 950 مثل 923 شما)
    // یا هر کلاسی را با اطمینان بالای 55 درصد تشخیص دهد، آن را به عنوان سند معتبر میپذیریم
    final bool isDocument =
        (maxIndex >= 900 && maxIndex <= 950) || normalizedConfidence > 0.55;
    final detectedType =
        isDocument ? DocumentType.receipt : DocumentType.background;

    return OmniClassificationResult(
      detectedType: detectedType,
      confidence: normalizedConfidence,
      isValid: detectedType == DocumentType.receipt,
    );
  }
}
