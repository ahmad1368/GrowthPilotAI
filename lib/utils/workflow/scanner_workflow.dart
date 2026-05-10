import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/image_source_sheet.dart';
import '../../core/services/ocr/ocr_service.dart';
import '../../core/services/ocr/omni_parser.dart';
import '../../widgets/omni_glass_panel.dart';
import '../../widgets/adaptive_text.dart';
import '../../services/scanner/scanner_service.dart';

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
    try {
      final File? croppedFile =
          await _scannerService.pickAndCrop(source, context);
      if (croppedFile == null) return;

      final result = await _ocrService.extractText(croppedFile);

      if (result != null && result.text.trim().isNotEmpty) {
        _showResultPanel(result.text, callback);
      } else {
        _showStatusPanel(
          title: "عدم شناسایی",
          message: "متنی در تصویر یافت نشد.",
          icon: Icons.search_off_rounded,
        );
      }
    } catch (e) {
      _showStatusPanel(
        title: "خطای سیستم",
        message: "در پردازش تصویر مشکلی پیش آمد.",
        icon: Icons.error_outline_rounded,
      );
    } finally {
      _ocrService.dispose();
    }
  }

  /// نمایش خروجی اصلی با OmniGlassPanel مستقیم
  void _showResultPanel(String text, Function(String) callback) {
    final currency = OmniParser.detectCurrency(text);
    final taxes = OmniParser.extractTaxes(text);

    Get.dialog(
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: OmniGlassPanel(
            title: "نتیجه اسکن",
            leadingIcon: Icons.document_scanner_outlined,
            // دکمه‌ها مستقیماً در پنل قرار می‌گیرند تا استایل فوتر حفظ شود
            actionButtons: [
              _buildActionButton(
                label: "تایید",
                onTap: () {
                  Get.back();
                  callback(text);
                },
                isPrimary: true,
              ),
              _buildActionButton(
                label: "لغو",
                onTap: () => Get.back(),
                isPrimary: false,
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
                      child: AdaptiveText(text,
                          style: const TextStyle(fontSize: 13)),
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

  /// نمایش وضعیت‌ها (خطا/هشدار) مستقیماً با OmniGlassPanel
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
              _buildActionButton(
                label: "بستن",
                onTap: () => Get.back(),
                isPrimary: false,
              ),
            ],
            child: AdaptiveText(message, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }

  /// متد کمکی برای ساخت دکمه‌ها با استفاده از خودِ OmniGlassPanel
  Widget _buildActionButton({
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    final isDark = Get.isDarkMode;
    return GestureDetector(
      onTap: onTap,
      child: OmniGlassPanel(
        opacity: isPrimary ? 0.2 : 0.05,
        isInteractive: true,
        backgroundColor:
            isPrimary ? (isDark ? Colors.tealAccent : Colors.teal) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: AdaptiveText(
            label,
            style: TextStyle(
              fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
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
