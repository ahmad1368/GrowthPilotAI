import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_service.dart';
import 'package:growth_pilot_ai/core/widgets/omni_step_progress.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_request.dart';
import 'package:growth_pilot_ai/features/detector/models/services/financial_parser.dart';
import 'package:growth_pilot_ai/features/document_classification/data/services/tflite_classifier_service.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/document/document_classifier.dart';
import '../../core/services/omni_logger.dart';
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
    // ریست صریح استیت‌ها برای جلوگیری از رفتارهای پیش‌بینی نشده در اسکن‌های بعدی
    _currentStepId.value = 'picking';
    _subProgress.value = 0.0;

    Get.bottomSheet(
      ImageSourceSheet(
        onSourceSelected: (source) async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 100));

          final outcome = await _processImageWorkflow(source, context);
          await Future.delayed(const Duration(milliseconds: 200));

          if (outcome.success) {
            if (outcome.data != null) {
              _showEnhancedResultPanel(
                outcome.data!,
                outcome.message ?? "نامشخص",
                onSave,
              );
            } else {
              _showStatusPanel(
                title: "خطای ساختار داده",
                message:
                    "پردازش با موفقیت انجام شد اما متن استخراج شده خالی است.",
                icon: Icons.data_object_rounded,
                context: context,
                onSave: onSave,
              );
            }
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

      if (!scannerRes.success) {
        if (isOverlayVisible) {
          Get.back();
          isOverlayVisible = false;
        }
        return OmniResponse.error(scannerRes.message ?? "خطا در اسکن");
      }

      _currentStepId.value = 'finalizing';
      _subProgress.value = 0.2;

      print("DEBUG: Scanner Path: ${scannerRes.data?.path}");

      final classifier = TFliteClassifierService();
      await classifier.loadModel();

      final classificationResult = await classifier.classifyDocument(
        File(scannerRes.data!.path),
      );

      OmniLogger.info(
        title: "ارزیابی کیفیت داکیومنت با TFLite",
        message: "میزان تطابق رسید: ${classificationResult.confidence}",
        widgetName: "ScannerWorkflow",
      );

      // لایه دربان سند مالی: در صورت نامعتبر بودن، پشته دیالوگ مدیریت شده و سریعاً قطع می‌شود
      if (!classificationResult.isValid) {
        classifier.dispose();
        if (isOverlayVisible) {
          isOverlayVisible = false;
          if (Get.isDialogOpen == true) Get.back();
          await Future.delayed(const Duration(milliseconds: 50));
        }
        return OmniResponse.error(
            "سند مالی معتبر تشخیص داده نشد. لطفاً فاکتور را در کادر تنظیم کنید.");
      }

      classifier.dispose();

      final ocrRes = await _ocrService.extractText(scannerRes.data!);
      if (ocrRes.success && ocrRes.data != null) {
        print("Final Text in Workflow: ${ocrRes.data!.fullText}");
      }

      if (!ocrRes.success) {
        if (isOverlayVisible) {
          Get.back();
          isOverlayVisible = false;
        }
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

      if (parserResponse.success && parserResponse.data != null) {
        final financialData = parserResponse.data!;
        print(
            "DEBUG [Issue #25]: Automatically Extracted Currency -> ${financialData.currency}");
        print(
            "DEBUG [Issue #25]: CRA Compliant Standard Date -> ${financialData.extractedDate}");
      } else {
        print(
            "DEBUG [Issue #25]: Financial extraction skipped or failed: ${parserResponse.message}");
      }

      _currentStepId.value = 'completed';
      _subProgress.value = 1.0;

      if (isOverlayVisible) {
        Get.back();
        isOverlayVisible = false;
      }

      return OmniResponse.success(ocrRes.data!,
          message: classRes.data?.toString() ?? "سایر موارد");
    } catch (e, stack) {
      if (isOverlayVisible) {
        Get.back();
      }
      OmniLogger.error(
        title: "خطای Workflow",
        message: e,
        stackTrace: stack,
        widgetName: "ScannerWorkflow",
      );
      return OmniResponse.error("خطای غیرمنتظره در جریان پردازش: $e");
    } finally {
      if (isOverlayVisible) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        isOverlayVisible = false;
      }
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

  void _showEnhancedResultPanel(
      OCRResult result, String initialType, Function(String) onSave) {
    final RxString rxDetectedType = initialType.obs;

    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: OmniGlassPanel(
              title: "نتیجه پردازش هوشمند",
              leadingIcon: Icons.auto_awesome_rounded,
              opacity: Get.isDarkMode ? 0.2 : 0.9,
              actionButtons: [
                OmniButton(
                  label: "تایید و ذخیره نهایی",
                  icon: Icons.save_rounded,
                  isPrimary: true,
                  onTap: () {
                    Get.back();
                    onSave(rxDetectedType.value);
                  },
                ),
                OmniButton(
                  label: "اسکن مجدد",
                  icon: Icons.refresh_rounded,
                  isPrimary: false,
                  onTap: () {
                    Get.back();
                    start(Get.context!, onSave);
                  },
                ),
              ],
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTypeSelectorSection(rxDetectedType),
                    const SizedBox(height: 20),
                    const AdaptiveText(
                      "متن شناسایی شده:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: AdaptiveText(
                        result.fullText ?? "متنی یافت نشد",
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.verified_user_outlined, size: 16),
                        const SizedBox(width: 8),
                        AdaptiveText(
                          "دقت پردازش: ${((result.confidence ?? 0.0) * 100).toStringAsFixed(1)}%",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showTypeSelectionPanel(RxString currentType) {
    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: OmniGlassPanel(
              title: "انتخاب نوع سند",
              leadingIcon: Icons.category_rounded,
              actionButtons: [
                OmniButton(
                  label: "انصراف",
                  icon: Icons.close_rounded,
                  isPrimary: false,
                  onTap: () => Get.back(),
                ),
              ],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: documentTypes.map((type) {
                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      title: AdaptiveText(
                        type,
                        style: TextStyle(
                          fontWeight: currentType.value == type
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      leading: Icon(
                        currentType.value == type
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                      ),
                      onTap: () {
                        currentType.value = type;
                        Get.back();
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelectorSection(RxString detectedType) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.cyanAccent.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AdaptiveText(
                  "طبقه‌بندی هوشمند:",
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Obx(() => AdaptiveText(
                      detectedType.value,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => _showTypeSelectionPanel(detectedType),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.edit_note_rounded,
                      size: 24,
                    ),
                    AdaptiveText(
                      "تغییر",
                      style: TextStyle(fontSize: 9),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                  // ۱. بستن خود دیالوگ خطا
                  Get.back();

                  // ۲. لایه امنیتی تزریق شده: اگر لایه لودینگ هوشمند TFLite یا هر دیالوگ دیگری هنوز در پشته باز مانده باشد، آن را هم فوراً می‌بندیم
                  if (Get.isDialogOpen == true) {
                    Get.back();
                  }
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
