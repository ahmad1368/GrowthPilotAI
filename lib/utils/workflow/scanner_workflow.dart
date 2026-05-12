import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/widgets/omni_step_progress.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/document/document_classifier.dart';
import '../../core/services/ocr/ocr_service.dart';
import '../../core/services/omni_logger.dart';
import '../../core/models/ocr_result.dart';
import '../../services/scanner/scanner_service.dart';

// ویجت‌های بازسازی شده
import '../../widgets/image_source_sheet.dart';
import '../../widgets/omni_glass_panel.dart';
import '../../widgets/adaptive_text.dart';
import '../../widgets/omni_button.dart';
import '../../core/constants/scan_pipelines.dart';

class ScannerWorkflow {
  final OCRService _ocrService = OCRService();
  final ScannerService _scannerService = ScannerService();

  // کنترل وضعیت پیشرفت برای نمایش در UI
  final RxString _currentStepId = 'pick'.obs;
  final RxDouble _subProgress = 0.0.obs;

  void start(BuildContext context, Function(String text) onTextExtracted) {
    Get.bottomSheet(
      ImageSourceSheet(
        onSourceSelected: (source) async {
          Get.back(); // بستن شیت انتخاب منبع
          await _processImageWorkflow(source, onTextExtracted, context);
        },
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  /// آزادسازی منابع برای جلوگیری از نشت حافظه (Memory Leak)
  void dispose() {
    // ۱. بستن سرویس OCR (بسیار مهم برای آزادسازی منابع سخت‌افزاری)
    _ocrService.dispose();

    // ۲. اگر از Rx استفاده می‌کنی، بستن آن‌ها ضروری نیست اما حرفه‌ای است
    // _currentStepId.close();
    // _subProgress.close();

    OmniLogger.info(
      title: "Workflow Disposed",
      message: "منابع جریان اسکن با موفقیت آزاد شدند.",
      widgetName: "ScannerWorkflow",
    );
  }

  Future<void> _processImageWorkflow(
    ImageSource source,
    Function(String) callback,
    BuildContext context,
  ) async {
    // نمایش یک آورلی (Overlay) هوشمند که نوار پیشرفت را نشان می‌دهد
    _showProgressOverlay();

    try {
      // ۱. مرحله انتخاب و برش (با گزارش لحظه‌ای پیشرفت)
      final File? croppedFile = await _scannerService.pickAndCrop(
        source,
        context,
        onProgress: (stepId, progress) {
          _currentStepId.value = stepId;
          _subProgress.value = progress;
        },
      );

      if (croppedFile == null) {
        Get.back(); // بستن آورلی در صورت لغو
        return;
      }

      // ۲. مرحله پردازش هوش مصنوعی (AI/OCR)
      _currentStepId.value = 'ai';
      _subProgress.value = 0.3; // شروع پردازش سنگین

      final OCRResult? result = await _ocrService.extractText(croppedFile);

      _subProgress.value = 0.8; // تحلیل متن
      final String detectedType =
          DocumentClassifier.detect(result?.fullText ?? "");

      _subProgress.value = 1.0;
      await Future.delayed(
          const Duration(milliseconds: 500)); // توقف کوتاه برای دیدن وضعیت ۱۰۰٪

      Get.back(); // بستن آورلی پیشرفت

      // ۳. نمایش نتیجه نهایی
      if (result != null && result.fullText.trim().isNotEmpty) {
        _showEnhancedResultPanel(result, detectedType, callback);
      } else {
        _showStatusPanel(
          title: "عدم شناسایی",
          message: "متنی در تصویر یافت نشد. لطفاً از وضوح تصویر مطمئن شوید.",
          icon: Icons.search_off_rounded,
        );
      }
    } catch (e, stack) {
      Get.back();
      OmniLogger.error(
        title: "خطای جریان اسکن",
        message: e.toString(),
        widgetName: "ScannerWorkflow",
      );
    }
  }

  /// نمایش یک آورلی شیشه‌ای که نوار پیشرفت را در کل صفحه مدیریت می‌کند
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

  /// پنل پیشرفته نمایش نتیجه با افکت‌های جدید
  void _showEnhancedResultPanel(
      OCRResult result, String detectedType, Function(String) callback) {
    final bool isDarkMode = Get.isDarkMode;
    final Color accentColor = Colors.cyanAccent;

    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: OmniGlassPanel(
              title: "تحلیل هوشمند سند",
              leadingIcon: Icons.auto_awesome_outlined,
              opacity: isDarkMode ? 0.1 : 0.9,
              actionButtons: [
                OmniButton(
                  label: "تایید و ذخیره",
                  icon: Icons.check_circle_outline_rounded,
                  isPrimary: true,
                  onTap: () {
                    Get.back();
                    callback(result.fullText);
                  },
                ),
                OmniButton(
                  label: "تلاش مجدد",
                  icon: Icons.refresh_rounded,
                  isPrimary: false,
                  onTap: () => Get.back(),
                ),
              ],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // سکشن نوع سند با طراحی بهبود یافته
                  _buildTypeSelectorSection(
                      detectedType, isDarkMode ? Colors.white : Colors.black),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(color: Colors.white10, height: 1),
                  ),

                  // باکس پیش‌نمایش متن با افکت لیزر مجازی (شبیه لودینگ ملایم)
                  _buildTextPreview(result.fullText, accentColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelectorSection(String type, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.cyan.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyan.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_rounded, color: Colors.cyanAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  "طبقه‌بندی هوشمند:",
                  style: TextStyle(
                      fontSize: 10, color: iconColor.withOpacity(0.5)),
                ),
                AdaptiveText(
                  type,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent),
                ),
              ],
            ),
          ),
          IconButton(
            icon:
                const Icon(Icons.swap_horiz_rounded, color: Colors.cyanAccent),
            onPressed: () => _showTypeChangeMenu(type),
          )
        ],
      ),
    );
  }

  Widget _buildTextPreview(String text, Color accentColor) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 180),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AdaptiveText(
          text,
          style: const TextStyle(fontSize: 13, height: 1.6, letterSpacing: 0.3),
        ),
      ),
    );
  }

  void _showTypeChangeMenu(String currentType) {
    OmniLogger.info(
      title: "تغییر نوع سند",
      message: "منوی تغییر طبقه‌بندی باز شد. فعلی: $currentType",
      widgetName: "ScannerWorkflow",
    );
    // اینجا می‌توانید یک Get.bottomSheet برای انتخاب دستی نوع سند باز کنید.
  }

  void _showStatusPanel(
      {required String title,
      required String message,
      required IconData icon}) {
    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: OmniGlassPanel(
            title: title,
            leadingIcon: icon,
            actionButtons: [
              OmniButton(
                label: "فهمیدم",
                icon: Icons.check_circle_outline_rounded, // آیکون اضافه شده
                isPrimary: false,
                onTap: () => Get.back(),
              ),
            ],
            child: AdaptiveText(message, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
