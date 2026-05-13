import 'dart:io';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/error/failure_mapper.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' show kIsWeb;

/// تعریف یک نوع داده برای گزارش پیشرفت
typedef ScanProgressCallback = void Function(String stepId, double subProgress);

class ScannerService {
  final ImagePicker _picker = ImagePicker();

  /// ۱. متد درخواست مجوزها (با گزارش وضعیت به UI)
  Future<bool> requestPermissions() async {
    if (kIsWeb) return true;

    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
    ].request();

    return statuses[Permission.camera]!.isGranted &&
        (statuses[Permission.storage]!.isGranted ||
            statuses[Permission.photos]!.isGranted);
  }

  /// متد اصلی انتخاب و آماده‌سازی تصویر با مدیریت خطای متمرکز
  /// [source]: منبع تصویر (دوربین یا گالری)
  /// [onProgress]: کالبک برای به‌روزرسانی نوار پیشرفت در UI
  Future<OmniResponse<File>> pickAndCrop(
    ImageSource source,
    BuildContext context, {
    void Function(String stepId, double progress)? onProgress,
  }) async {
    try {
      // ۱. شروع فرآیند و لاگ اولیه
      OmniLogger.info(
          title: "شروع فرایند",
          message: "شروع فرآیند انتخاب تصویر از ${source.name}",
          widgetName: "ScannerService");
      onProgress?.call('picking', 0.2);

      // ۲. انتخاب تصویر از ImagePicker
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85, // تعادل بین کیفیت OCR و حجم فایل
      );

      // ۳. بررسی انصراف کاربر
      if (pickedFile == null) {
        OmniLogger.warning(
            title: "انصراف", message: "کاربر از انتخاب تصویر منصرف شد.");
        return OmniResponse.error("عملیات توسط کاربر لغو شد.");
      }

      // ۴. مرحله برش تصویر (Crop)
      onProgress?.call('cropping', 0.5);
      OmniLogger.info(
          title: "انتقال به مرحله بعد",
          message: "در حال انتقال به مرحله برش تصویر...");

      // تبدیل XFile به File برای پردازش‌های بعدی
      final File imageFile = File(pickedFile.path);

      /* 
         نکته: اگر پکیج image_cropper را نصب دارید، منطق آن را اینجا صدا بزنید.
         فعلاً تصویر اصلی را برای نهایی‌سازی آماده می‌کنیم.
      */

      // ۵. نهایی‌سازی (مثلاً فشرده‌سازی یا بررسی سلامت فایل)
      onProgress?.call('finalizing', 0.8);

      if (!await imageFile.exists()) {
        throw FileSystemException("فایل انتخاب شده یافت نشد", imageFile.path);
      }

      onProgress?.call('completed', 1.0);
      OmniLogger.info(
          title: "آماده",
          message: "فایل با موفقیت آماده شد: ${imageFile.path}");

      // ۶. خروجی موفقیت‌آمیز در قالب استاندارد پروژه
      return OmniResponse.success(
        imageFile,
        message: "تصویر با موفقیت انتخاب و پردازش شد.",
      );
    } catch (e, stack) {
      // استفاده حرفه‌ای از FailureMapper برای مدیریت خطاهای پیش‌بینی نشده
      // نوع جنریک <File> تضمین می‌کند که خروجی با امضای تابع همخوانی دارد
      return FailureMapper.map<File>(e, stack: stack);
    }
  }

  /// ۳. متد ذخیره دائمی
  Future<File> saveFilePermanently(File tempFile) async {
    if (kIsWeb) return tempFile;

    final directory = await getApplicationDocumentsDirectory();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String extension = p.extension(tempFile.path);
    final String fileName = "doc_$timestamp$extension";

    final String permanentPath = p.join(directory.path, fileName);
    final File permanentFile = await tempFile.copy(permanentPath);

    debugPrint("📂 فایل با موفقیت در حافظه ماندگار شد: $permanentPath");
    return permanentFile;
  }
}
