import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/services/ocr/omni_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/image_source_sheet.dart';
import '../../core/services/ocr/ocr_service.dart';
import '../../core/utils/omni_logger.dart';
import '../../widgets/common/omni_error_dialog.dart';
import '../../services/scanner/scanner_service.dart';

class ScannerWorkflow {
  final OCRService _ocrService = OCRService();
  final ScannerService _scannerService = ScannerService();

  /// شروع فرآیند اسکن و نمایش منوی انتخاب منبع
  void start(BuildContext context, Function(String text) onTextExtracted) {
    // OmniLogger.log(
    //   title: "دستیار هوشمند مالی",
    //   message: "لطفاً تصویر رسید را وارد کنید تا تحلیل هوشمند آغاز شود 🧠",
    //   type: OmniMessageType.info,
    // );

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

  /// مدیریت زنجیره عملیات: دریافت تصویر -> OCR -> تحلیل هوشمند
  Future<void> _processImageWorkflow(ImageSource source,
      Function(String) callback, BuildContext context) async {
    try {
      final File? croppedFile =
          await _scannerService.pickAndCrop(source, context);
      if (croppedFile == null) return;

      final result = await _ocrService.extractText(croppedFile);
      if (result != null) {
        await _analyzeAndValidate(result.text, callback);
      }
    } catch (e) {
      _handleError(e);
    } finally {
      _ocrService.dispose();
    }
  }

  /// تحلیل هوشمند محتوا (جلوگیری از تکرار و دسته‌بندی)
  Future<void> _analyzeAndValidate(
      String text, Function(String) callback) async {
    // ۱. استخراج فرضی (در Issue #15 واقعی می‌شود)
    final String shopName = "Walmart";
    final String date = "2026-05-08";

    // ۲. بررسی تکراری بودن (شبیه‌سازی منطق دیتابیس)
    bool isDuplicate = false;

    if (isDuplicate) {
      _showDuplicateWarning(shopName, date, text, callback);
    } else {
      _showSmartSuccess(text, callback);
    }
  }

  /// نمایش هشدار برای رسیدهای تکراری
  void _showDuplicateWarning(
      String shop, String date, String text, Function(String) cb) {
    OmniLogger.log(
      title: "رسید تکراری شناسایی شد! 🛑",
      message:
          "این فاکتور قبلاً در تاریخ $date از فروشگاه $shop ثبت شده است.\n\n"
          "ثبت مجدد هزینه‌ها باعث اختلال در تحلیل سود و زیان و گزارش‌های مالیاتی شما می‌شود.",
      type: OmniMessageType.warning,
      actionLabel: "ثبت مجدد (توصیه نمی‌شود)",
      onAction: () => cb(text),
    );
  }

  /// نمایش موفقیت و پیشنهاد دسته‌بندی هوشمند
  void _showSmartSuccess(String text, Function(String) cb) {
    final suggestion = _getCategorySuggestion(text);
    final currency = OmniParser.detectCurrency(text);
    final taxes = OmniParser.extractTaxes(text);

    // ساخت پیام مالیاتی اگر مالیاتی پیدا شده باشد
    String taxInfo = "";
    if (taxes.isNotEmpty) {
      taxInfo = "\n\n📌 **یادآور مالیاتی:**\n";
      taxes.forEach((key, value) => taxInfo += "• $key: \$$value\n");
      taxInfo += "*(این مبالغ برای اظهارنامه مالیاتی فصلی ذخیره می‌شوند)*";
    }

    OmniLogger.log(
      title: "تحلیل هوشمند موفق ✅",
      message: "💡 پیشنهاد دسته: [$suggestion]\n"
          "💵 ارز شناسایی شده: $currency"
          "$taxInfo\n\n"
          "محتوای استخراج شده:\n$text",
      type: OmniMessageType.success,
      footer: "توصیه: رسیدهای بیزنسی شامل GST را حتماً تایید کنید.",
      actionLabel: "تایید و ثبت در $suggestion",
      onAction: () => cb(text),
    );
  }

  /// موتور حدس دسته‌بندی بر اساس محتوا (زیر ۵۰ خط)
  String _getCategorySuggestion(String text) {
    final lowerText = text.toLowerCase();
    if (lowerText.contains('gas') || lowerText.contains('fuel'))
      return "حمل و نقل 🚗";
    if (lowerText.contains('food') || lowerText.contains('mart'))
      return "مواد غذایی 🛒";
    if (lowerText.contains('restaurant') || lowerText.contains('cafe'))
      return "رستوران ☕";
    return "عمومی 📦";
  }

  void _handleError(dynamic e) {
    OmniLogger.log(
      title: "خطا در پردازش",
      message: "سیستم قادر به تحلیل این رسید نبود.",
      type: OmniMessageType.error,
      footer: "Error: $e",
    );
  }

  void dispose() => _ocrService.dispose();
}
