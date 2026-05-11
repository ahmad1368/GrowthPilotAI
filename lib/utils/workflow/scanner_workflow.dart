import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/image_source_sheet.dart';
import '../../core/services/ocr/ocr_service.dart';
import '../../core/services/ocr/omni_parser.dart';
import '../../widgets/omni_glass_panel.dart';
import '../../widgets/adaptive_text.dart';
import '../../widgets/omni_button.dart';
import '../../services/scanner/scanner_service.dart';
import '../../core/models/ocr_result.dart'; // این خط را اضافه کنید
import '../../core/services/omni_logger.dart'; // وارد کردن لاگر متمرکز

class ScannerWorkflow {
  final OCRService _ocrService = OCRService();
  final ScannerService _scannerService = ScannerService();

  void start(BuildContext context, Function(String text) onTextExtracted) {
    Get.bottomSheet(
      ImageSourceSheet(
        onSourceSelected: (source) async {
          Get.back();
          await _processImageWorkflow(source, onTextExtracted, context);
        },
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Future<void> _processImageWorkflow(ImageSource source,
      Function(String) callback, BuildContext context) async {
    final localOCR = OCRService();

    try {
      final File? croppedFile =
          await _scannerService.pickAndCrop(source, context);
      if (croppedFile == null) return;

      // اصلاح این خط: تغییر نوع متغیر از String? به OCRResult?
      final OCRResult? result = await localOCR.extractText(croppedFile);

      // بررسی وجود نتیجه و استخراج متن از داخل آن
      if (result != null && result.fullText.trim().isNotEmpty) {
        // پاس دادن کل شیء result به جای فقط متن
        _showResultPanel(result, callback);
      } else {
        _showStatusPanel(
            title: "عدم شناسایی",
            message: "متنی در تصویر یافت نشد.",
            icon: Icons.search_off);
      }
    } catch (e, stack) {
      // ... کدهای مربوط به مدیریت خطا (بدون تغییر باقی بماند) ...
    } finally {
      localOCR.dispose();
    }
  }

  /// نمایش پنل نتیجه اسکن - سازگار شده با مدل OCRResult
  void _showResultPanel(OCRResult result, Function(String) callback) {
    // استخراج متن اصلی از مدل برای استفاده در پارسرها و نمایش
    final String extractedText = result.fullText;

    final currency = OmniParser.detectCurrency(extractedText);
    final taxes = OmniParser.extractTaxes(extractedText);

    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: OmniGlassPanel(
            title: "نتیجه اسکن",
            opacity: Get.isDarkMode ? 0.1 : 0.9,
            leadingIcon: Icons.document_scanner_outlined,
            actionButtons: [
              OmniButton(
                label: "تایید",
                icon: Icons.check_rounded,
                width: 110,
                isPrimary: true,
                onTap: () {
                  Get.back();
                  // ارسال متن نهایی به کال‌بک اصلی برنامه
                  callback(extractedText);
                },
              ),
              OmniButton(
                label: "لغو",
                icon: Icons.close_rounded,
                width: 90,
                isPrimary: false,
                onTap: () => Get.back(),
              ),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _infoRow("واحد پول:", currency),
                if (taxes.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  ...taxes.entries
                      .map((e) => _infoRow("${e.key}:", "${e.value}")),
                ],
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(color: Colors.white10, height: 1),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Opacity(
                      opacity: 0.8,
                      child: AdaptiveText(
                        extractedText,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// نمایش پنل‌های وضعیت (خطا، هشدار، موفقیت)
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
            opacity: Get.isDarkMode ? 0.1 : 0.9,
            leadingIcon: icon,
            actionButtons: [
              OmniButton(
                label: "بستن",
                icon: Icons.done_all_rounded,
                width: 120,
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

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: 0.6,
          child: AdaptiveText(label, style: const TextStyle(fontSize: 12)),
        ),
        AdaptiveText(value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  void dispose() => _ocrService.dispose();
}
