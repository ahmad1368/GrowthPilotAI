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
import '../../core/utils/logger.dart';

class ScannerPipelineProcessor {
  const ScannerPipelineProcessor();

  Future<OmniResponse<OCRResult>> runHeavyClassificationAndOcr(
      File file, RxDouble subProgress) async {
    final classifier = TFliteClassifierService();
    await classifier.loadModel();
    final classificationResult = await classifier.classifyDocument(file);

    OmniLogger.log(
      level: "INFO",
      message: "ارزیابی با TFLite | تطابق: ${classificationResult.confidence}",
      worker: "Ahmad_Salem_Pour",
      serviceName: "ScannerWorkflow",
    );

    if (!classificationResult.isValid) {
      classifier.dispose();
      return OmniResponse.error("سند مالی معتبر تشخیص داده نشد.");
    }
    classifier.dispose();

    final ocrRes = await Get.find<OCRService>().extractText(file);
    if (!ocrRes.success)
      return OmniResponse.error(ocrRes.message ?? "خطا در استخراج متن");

    subProgress.value = 0.7;
    final classRes = DocumentClassifier.detect(ocrRes.data!.fullText);
    final parserResponse = await FinancialParser().parse(
        FinancialParserRequest(lines: ocrRes.data!.fullText.split('\n')));

    DateTime parsedDate = DateTime.now();
    if (parserResponse.success && parserResponse.data != null) {
      parsedDate = parserResponse.data!.extractedDate;
    }

    subProgress.value = 1.0;
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

  void logError(dynamic e, StackTrace stack) {
    OmniLogger.error(
      message: "خطای Workflow: ${e.toString()}",
      worker: "Ahmad_Salem_Pour",
      serviceName: "ScannerWorkflow",
      exception: e,
      stackTrace: stack,
    );
  }
}
