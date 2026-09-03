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

    // سند معتبر فقط وقتی پذیرفته می‌شود که هر دو شرط برقرار باشد: کلاس پیش‌بینی‌شده
    // در رنج کلاس‌های کاغذ/مستندات (900 تا 950، مثل 923) باشد و اطمینان از حد
    // آستانه‌ی Issue #25 (۷۰٪) بیشتر باشد. قبلاً شرط با "یا" نوشته شده بود که هر
    // تصویری با اطمینان بالای ۵۵٪ (مثلاً یک عکس از مانیتور کامپیوتر) را هم به‌عنوان
    // رسید معتبر می‌پذیرفت — دقیقاً همان موردی که این ایشیو باید رد کند.
    final bool isDocument =
        maxIndex >= 900 && maxIndex <= 950 && normalizedConfidence > 0.70;
    final detectedType =
        isDocument ? DocumentType.receipt : DocumentType.background;

    return OmniClassificationResult(
      detectedType: detectedType,
      confidence: normalizedConfidence,
      isValid: detectedType == DocumentType.receipt,
    );
  }
}
