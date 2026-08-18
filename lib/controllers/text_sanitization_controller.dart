import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/sanitize_document_text.dart';
import 'package:growth_pilot_ai/core/models/sanitized_text_result.dart';

/// Drives the "Diff View" + "Advanced Cleaning" toggle (Issue #227).
class TextSanitizationController extends GetxController {
  final result = Rxn<SanitizedTextResult>();
  final stripBoilerplate = true.obs;
  final showSanitized = true.obs;

  void sanitize(String rawText) {
    result.value = SanitizeDocumentText.call(rawText, stripBoilerplate: stripBoilerplate.value);
  }

  void toggleStripBoilerplate(bool value) {
    stripBoilerplate.value = value;
    final raw = result.value?.rawText;
    if (raw != null) sanitize(raw);
  }
}
