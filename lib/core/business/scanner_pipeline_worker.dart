import 'dart:io';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';
import 'package:growth_pilot_ai/features/document_classification/business/ocr_service.dart';
import 'package:growth_pilot_ai/features/document_classification/data/services/tflite_classifier_service.dart';
import 'package:growth_pilot_ai/features/detector/models/services/financial_parser.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_request.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/pages/ocr_confirmation_page.dart';
import '../../core/services/document/document_classifier.dart';
import '../utils/logger.dart';

class ScannerPipelineWorker {
  const ScannerPipelineWorker();

  Future<OmniResponse<OCRResult>> processHeavyAiTasks(
      File file, RxDouble progress) async {
    final classifier = TFliteClassifierService();
    await classifier.loadModel();
    final classification = await classifier.classifyDocument(file);

    if (!classification.isValid) {
      classifier.dispose();
      return OmniResponse.error("سند مالی معتبر تشخیص داده نشد.");
    }
    classifier.dispose();

    final ocrRes = await Get.find<OCRService>().extractText(file);
    if (!ocrRes.success)
      return OmniResponse.error(ocrRes.message ?? "خطا در استخراج متن");

    progress.value = 0.7;
    final classRes = DocumentClassifier.detect(ocrRes.data!.fullText);
    final parserResponse = await FinancialParser().parse(
        FinancialParserRequest(lines: ocrRes.data!.fullText.split('\n')));

    final parsedDate = parserResponse.success && parserResponse.data != null
        ? parserResponse.data!.extractedDate
        : DateTime.now();

    progress.value = 1.0;
    return OmniResponse.success(ocrRes.data!,
        message:
            "${classRes.data ?? "سایر موارد"}|${file.path}|${parsedDate.toIso8601String()}");
  }

  void navigateToConfirmation(OCRResult result, String payload) {
    final parts = payload.split('|');
    Get.to(() => OcrConfirmationView(
            initialData: OcrFormData(
          amount: result.confidence ?? 0.0,
          date: parts.length > 2
              ? (DateTime.tryParse(parts[2]) ?? DateTime.now())
              : DateTime.now(),
          vendorName: parts[0],
          description: result.fullText ?? "",
          receiptImage: File(parts.length > 1 ? parts[1] : ''),
        )));
  }

  void logPipelineError(dynamic e, StackTrace stack) {
    OmniLogger.error(
      message: "خطای Workflow: پردازش ناگهانی متوقف شد",
      worker: "Ahmad_Salem_Pour",
      serviceName: "ScannerWorkflow",
      exception: e.toString(), // دیتای خام متون خطا در این پارامتر قرار می‌گیرد
      stackTrace: stack,
    );
  }
}
