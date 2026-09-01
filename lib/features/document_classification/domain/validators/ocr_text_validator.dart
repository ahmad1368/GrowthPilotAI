import 'package:growth_pilot_ai/core/models/omni_response.dart';

class OcrTextValidator {
  static OmniResponse<String> validate(String? text) {
    final cleaned = text?.trim() ?? "";

    if (cleaned.isEmpty) {
      // تغییر .failure به .error بر اساس ساختار OmniResponse
      // استفاده از یک Failure عینی و معتبر به جای کلاس انتزاعی OmniFailure
      return OmniResponse<String>.error(
        "NO_TEXT_DETECTED",
      );
    }

    return OmniResponse<String>.success(cleaned);
  }
}
