import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_service.dart';
import 'package:growth_pilot_ai/core/widgets/omni_step_progress.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/document/document_classifier.dart';
import '../../core/services/omni_logger.dart';
import '../../services/scanner/scanner_service.dart';
// ویجت‌های بازسازی شده
import '../../widgets/image_source_sheet.dart';
import '../../widgets/omni_glass_panel.dart';
import '../../widgets/adaptive_text.dart';
import '../../widgets/omni_button.dart';
import '../../core/constants/scan_pipelines.dart';

class ScannerWorkflow {
  // ۱. لیست انواع سند را اینجا تعریف کن
  final List<String> documentTypes = [
    "رسید بانکی",
    "فاکتور خرید",
    "کارت شناسایی",
    "قرارداد رسمی",
    "سایر موارد"
  ];
// به جای ساختن، سرویس‌های آماده را از حافظه فراخوانی می‌کنیم
  final _ocrService = Get.find<OCRService>();
  final _scannerService = Get.find<ScannerService>();

  // کنترل وضعیت پیشرفت برای نمایش در UI
  final RxString _currentStepId = 'picking'.obs;
  final RxDouble _subProgress = 0.0.obs;

  void start(BuildContext context, Function(String) onSave) async {
    Get.bottomSheet(
      ImageSourceSheet(
        onSourceSelected: (source) async {
          // ۱. ابتدا باتم‌شیت انتخاب منبع عکس را کاملاً می‌بندیم
          Get.back();

          // یک تاخیر مایکروثانیه‌ای برای اینکه پشته ناویگیشن متوجه بسته شدن باتم‌شیت بشود
          await Future.delayed(const Duration(milliseconds: 100));

          // ۲. اجرای فرآیند اصلی پردازش تصویر (شامل لودینگ، کراپ، OCR و تشخیص هوشمند)
          final outcome = await _processImageWorkflow(source, context);

          // ۳. پس از پایان کامل فرآیند، برای خروج انیمیشن لودینگ یک تنفس کوتاه ایجاد می‌کنیم
          await Future.delayed(const Duration(milliseconds: 200));

          // ۴. مدیریت هوشمند باز کردن پنل نهایی بر اساس وضعیت موفقیت
          if (outcome.success) {
            if (outcome.data != null) {
              _showEnhancedResultPanel(
                outcome.data!,
                outcome.message ?? "نامشخص",
                onSave,
              );
            } else {
              // اگر موفقیت ثبت شده ولی دیتا به هر دلیلی نال بود، پوشش امنیتی خطا قرار می‌دهیم
              _showStatusPanel(
                title: "خطای ساختار داده",
                message:
                    "پردازش با موفقیت انجام شد اما متن استخراج شده خالی است.",
                icon: Icons.data_object_rounded,
              );
            }
          } else {
            // نمایش پنل خطای متمرکز با متون انطباق یافته AdaptiveText
            _showStatusPanel(
              title: "پردازش ناموفق",
              message:
                  outcome.message ?? "خطای ناشناخته در لایه پردازش هوش مصنوعی",
              icon: Icons.warning_amber_rounded,
            );
          }
        },
      ),
    );
  }

  void dispose() {
    _ocrService.dispose();
    // بستن صریح جریان‌های Rx برای جلوگیری از نشت حافظه در صورت استفاده طولانی
    _currentStepId.close();
    _subProgress.close();

    OmniLogger.info(
      title: "Workflow Disposed",
      message: "تمامی استریم‌ها و منابع سخت‌افزاری آزاد شدند.",
      widgetName: "ScannerWorkflow",
    );
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
      isOverlayVisible = true; // علامت‌گذاری اینکه آورلی نمایش داده شده

      // ۱. مرحله انتخاب (Picking)
      final scannerRes = await _scannerService.pickAndCrop(
        source,
        context,
        onProgress: (stepId, subValue) {
          _currentStepId.value = stepId;
          _subProgress.value = subValue;
        },
      );

      if (!scannerRes.success) {
        // اگر آورلی باز است، آن را می‌بندیم تا کاربر به صفحه قبل برگردد
        if (isOverlayVisible) {
          Get.back();
          isOverlayVisible = false;
        }
        return OmniResponse.error(scannerRes.message ?? "خطا در اسکن");
      }

      // ۲. مرحله پردازش هوش مصنوعی (Finalizing)
      _currentStepId.value = 'finalizing';
      _subProgress.value = 0.1;

      print("DEBUG: Scanner Path: ${scannerRes.data?.path}");

      final ocrRes = await _ocrService.extractText(scannerRes.data!);
      // تست مقدار قبل از رفتن به مرحله بعد
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

      // ۳. مرحله تشخیص هوشمند
      final classRes = await DocumentClassifier.detect(ocrRes.data!.fullText);

      // ۴. مرحله اتمام (Completed)
      _currentStepId.value = 'completed';
      _subProgress.value = 1.0;

      await Future.delayed(const Duration(milliseconds: 500));

      if (isOverlayVisible) {
        Get.back(); // بستن آورلی پیشرفت قبل از نمایش نتیجه
        isOverlayVisible = false;
      }

      return OmniResponse.success(ocrRes.data!,
          message: classRes.data?.toString() ?? "سایر موارد");
    } catch (e, stack) {
      // در صورت بروز هرگونه خطای پیش‌بینی نشده
      if (isOverlayVisible) {
        Get.back(); // آزاد کردن صفحه
      }

      OmniLogger.error(
        title: "خطای Workflow",
        message: e,
        stackTrace: stack,
        widgetName: "ScannerWorkflow",
      );
      return OmniResponse.error("خطای غیرمنتظره در جریان پردازش: $e");
    } finally {
      // ۶. این همان بخش جادویی است که دنبالش بودید!
      // چه کد با موفقیت اجرا شود و چه با خطا به Catch برود،
      // دستور Get.back() در اینجا اجرا می‌شود و لایه لودینگ بسته می‌شود.
      if (isOverlayVisible) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        isOverlayVisible = false;
      }
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

  void _showEnhancedResultPanel(
      OCRResult result, String initialType, Function(String) onSave) {
    // تبدیل رشته معمولی به واکنشی برای هماهنگی با Obx و متد انتخاب نوع سند
    final RxString rxDetectedType = initialType.obs;

    Get.dialog(
      barrierDismissible: false, // جلوگیری از بسته شدن ناگهانی
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
                    Get.back(); // بستن دیالوگ
                    onSave(rxDetectedType
                        .value); // بازگرداندن مقدار نهایی انتخاب شده
                  },
                ),
                OmniButton(
                  label: "اسکن مجدد",
                  icon: Icons.refresh_rounded,
                  isPrimary: false,
                  onTap: () => Get.back(),
                ),
              ],
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ۱. بخش انتخاب و نمایش نوع سند (که قبلاً نوشتیم)
                    _buildTypeSelectorSection(
                        rxDetectedType, Colors.cyanAccent),

                    const SizedBox(height: 20),

                    // ۲. نمایش متن استخراج شده
                    const AdaptiveText(
                      "متن شناسایی شده:",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
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

                    // ۳. نمایش درصد اطمینان (Confidence)
                    Row(
                      children: [
                        const Icon(Icons.verified_user_outlined,
                            size: 16, color: Colors.greenAccent),
                        const SizedBox(width: 8),
                        AdaptiveText(
                          "دقت پردازش: ${((result.confidence ?? 0.0) * 100).toStringAsFixed(1)}%",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.greenAccent),
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
              opacity: Get.isDarkMode ? 0.15 : 0.9,
              // دکمه بستن در پایین
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
                          color: currentType.value == type
                              ? Colors.cyanAccent
                              : Colors.white,
                          fontWeight: currentType.value == type
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      leading: Icon(
                        currentType.value == type
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: currentType.value == type
                            ? Colors.cyanAccent
                            : Colors.white30,
                      ),
                      onTap: () {
                        currentType.value =
                            type; // تغییر مقدار به صورت Reactive
                        Get.back(); // بستن پنل بعد از انتخاب
                        OmniLogger.info(
                          title: "تغییر طبقه‌بندی",
                          message: "نوع سند به $type تغییر یافت.",
                          widgetName: "ScannerWorkflow",
                        );
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

  Widget _buildTypeSelectorSection(RxString detectedType, Color iconColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // استفاده از رنگ سایان بسیار ملایم برای متمایز کردن بخش انتخابگر
        color: Colors.cyanAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // آیکون وضعیت که حس بصری بهتری منتقل می‌کند
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: Colors.cyanAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // بخش متون (عنوان و مقدار واکنشی)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  "طبقه‌بندی هوشمند:",
                  style: TextStyle(
                    fontSize: 10,
                    color: iconColor.withOpacity(0.6),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                // بخش واکنشی که به محض انتخاب نوع جدید، آپدیت می‌شود
                Obx(() => AdaptiveText(
                      detectedType.value,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyanAccent,
                      ),
                    )),
              ],
            ),
          ),

          // دکمه ویرایش برای باز کردن پنل انتخاب
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => _showTypeSelectionPanel(detectedType),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.edit_note_rounded,
                      color: Colors.cyanAccent,
                      size: 24,
                    ),
                    AdaptiveText(
                      "تغییر",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.cyanAccent.withOpacity(0.8),
                      ),
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
