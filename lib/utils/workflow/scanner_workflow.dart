import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/ocr_form_data.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_service.dart';
import 'package:growth_pilot_ai/core/widgets/omni_step_progress.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_request.dart';
import 'package:growth_pilot_ai/features/detector/models/services/financial_parser.dart';
import 'package:growth_pilot_ai/features/document_classification/data/services/tflite_classifier_service.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/views/ocr_confirmation_view.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/document/document_classifier.dart';
import '../../core/utils/logger.dart';
import '../../services/scanner/scanner_service.dart';
import '../../widgets/image_source_sheet.dart';
import '../../widgets/omni_glass_panel.dart';
import '../../widgets/adaptive_text.dart';
import '../../widgets/omni_button.dart';
import '../../core/constants/scan_pipelines.dart';

class ScannerWorkflow {
  final List<String> documentTypes = [
    "رسید بانکی",
    "فاکتور خرید",
    "کارت شناسایی",
    "قرارداد رسمی",
    "سایر موارد"
  ];

  final _ocrService = Get.find<OCRService>();
  final _scannerService = Get.find<ScannerService>();

  final RxString _currentStepId = 'picking'.obs;
  final RxDouble _subProgress = 0.0.obs;

  void start(BuildContext context, Function(String) onSave) async {
    _currentStepId.value = 'picking';
    _subProgress.value = 0.0;

    Get.bottomSheet(
      ImageSourceSheet(
        onSourceSelected: (source) async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 100));
          if (!context.mounted) return;

          final outcome = await _processImageWorkflow(source, context);

          // زمان دادن به فریم‌ورک برای بستن کامل دیالوگ لودینگ قبلی
          await Future.delayed(const Duration(milliseconds: 250));
          if (!context.mounted) return;

          if (outcome.success && outcome.data != null) {
            _navigateToConfirmation(
                outcome.data!, outcome.message ?? "سایر موارد");
          } else {
            _showStatusPanel(
              title: "پردازش ناموفق",
              message:
                  outcome.message ?? "خطای ناشناخته در لایه پردازش هوش مصنوعی",
              icon: Icons.warning_amber_rounded,
              context: context,
              onSave: onSave,
            );
          }
        },
      ),
    );
  }

  void dispose() {
    _ocrService.dispose();
    _currentStepId.close();
    _subProgress.close();
  }

  OmniResult<OCRResult> startProcess(
      ImageSource source, BuildContext context) async {
    return await _processImageWorkflow(source, context);
  }

  Future<OmniResponse<OCRResult>> _processImageWorkflow(
      ImageSource source, BuildContext context) async {
    bool isOverlayVisible = false;

    try {
      _showProgressOverlay();
      isOverlayVisible = true;

      final scannerRes = await _scannerService.pickAndCrop(
        source,
        context,
        onProgress: (stepId, subValue) {
          _currentStepId.value = stepId;
          _subProgress.value = subValue;
        },
      );

      if (!scannerRes.success || scannerRes.data == null) {
        if (isOverlayVisible) Get.back();
        return OmniResponse.error(scannerRes.message ?? "خطا در اسکن");
      }

      _currentStepId.value = 'finalizing';
      _subProgress.value = 0.2;

      final classifier = TFliteClassifierService();
      await classifier.loadModel();

      final classificationResult = await classifier.classifyDocument(
        File(scannerRes.data!.path),
      );

      OmniLogger.info(
          "ارزیابی کیفیت داکیومنت با TFLite (ScannerWorkflow): میزان تطابق رسید: ${classificationResult.confidence}");

      if (!classificationResult.isValid) {
        classifier.dispose();
        if (isOverlayVisible) {
          if (Get.isDialogOpen == true) Get.back();
        }
        return OmniResponse.error("سند مالی معتبر تشخیص داده نشد.");
      }

      classifier.dispose();

      final ocrRes = await _ocrService.extractText(scannerRes.data!);
      if (!ocrRes.success) {
        if (isOverlayVisible) Get.back();
        return OmniResponse.error(ocrRes.message ?? "خطا در استخراج متن");
      }

      _subProgress.value = 0.7;

      final classRes = DocumentClassifier.detect(ocrRes.data!.fullText);
      final financialParser = FinancialParser();

      final parserResponse = await financialParser.parse(
        FinancialParserRequest(
          lines: ocrRes.data!.fullText.split('\n'),
        ),
      );

      DateTime parsedDate = DateTime.now();
      double parsedAmount = 0.0;

      if (parserResponse.success && parserResponse.data != null) {
        final financialData = parserResponse.data!;
        parsedDate = financialData.extractedDate;
        parsedAmount = financialData.amount ?? 0.0;

        OmniLogger.info(
            "استخراج اطلاعات مالی موفق (ScannerWorkflow): ارز: ${financialData.currency} | تاریخ: $parsedDate | مبلغ: $parsedAmount");
      }

      _currentStepId.value = 'completed';
      _subProgress.value = 1.0;

      if (isOverlayVisible) Get.back();

      return OmniResponse.success(ocrRes.data!,
          message: "${classRes.data ?? "سایر موارد"}|${scannerRes.data!.path}|"
              "${parsedDate.toIso8601String()}|$parsedAmount");
    } catch (e, stack) {
      if (isOverlayVisible) Get.back();
      OmniLogger.error(
        title: "خطای Workflow",
        message: e,
        stackTrace: stack,
        widgetName: "ScannerWorkflow",
      );
      return OmniResponse.error("خطای غیرمنتظره در جریان پردازش: $e");
    }
  }

  void _showProgressOverlay() {
    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Obx(() => OmniStepProgress(
                allSteps: ScanPipelines.docScanSteps,
                currentStepId: _currentStepId.value,
                subProgress: _subProgress.value,
              )),
        ),
      ),
    );
  }

  void _navigateToConfirmation(OCRResult result, String payload) {
    final parts = payload.split('|');
    final docType = parts[0];
    final imagePath = parts.length > 1 ? parts[1] : '';
    final date = parts.length > 2
        ? (DateTime.tryParse(parts[2]) ?? DateTime.now())
        : DateTime.now();
    // [Issue #23] مبلغ واقعی رسید (نه امتیاز اطمینان OCR) از نتیجه‌ی
    // FinancialParser می‌آید که در payload چهارمین بخش است.
    final amount = parts.length > 3 ? double.tryParse(parts[3]) ?? 0.0 : 0.0;

    Get.to(() => OcrConfirmationView(
          initialData: OcrFormData(
            amount: amount,
            date: date,
            vendorName: docType,
            description: result.fullText,
            receiptImage: File(imagePath),
          ),
        ));
  }

  void _showStatusPanel({
    required String title,
    required String message,
    required IconData icon,
    required BuildContext context,
    required Function(String) onSave,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: OmniGlassPanel(
            title: title,
            leadingIcon: icon,
            actionButtons: [
              OmniButton(
                label: "اسکن مجدد سند",
                icon: Icons.refresh_rounded,
                isPrimary: true,
                onTap: () {
                  Get.back();
                  start(context, onSave);
                },
              ),
              OmniButton(
                label: "انصراف",
                icon: Icons.cancel_outlined,
                isPrimary: false,
                onTap: () {
                  Get.back();
                  if (Get.isDialogOpen == true) Get.back();
                },
              ),
            ],
            child: AdaptiveText(message, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
