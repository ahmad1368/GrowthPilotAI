import 'dart:io';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/error/failure_mapper.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:image_cropper/image_cropper.dart';
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

  /// مرحله انتخاب و برش تصویر با مدیریت جامع خطا، لاگینگ و گزارش پیشرفت
  OmniResult<File> pickAndCrop(
    ImageSource source,
    BuildContext context, {
    ScanProgressCallback? onProgress, // اضافه شدن این پارامتر
  }) async {
    try {
      // ۱. گزارش شروع فرآیند انتخاب
      onProgress?.call('picking', 0.1);
      OmniLogger.info(
          title: "ScannerService",
          message: "شروع فرآیند انتخاب تصویر از: ${source.name}");

      // ۲. انتخاب تصویر
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );

      if (pickedFile == null) {
        OmniLogger.info(
            title: "ScannerService",
            message: "کاربر از انتخاب تصویر انصراف داد.");
        return OmniResponse.error("عملیات توسط کاربر لغو شد.", statusCode: 401);
      }

      // ۳. گزارش شروع فرآیند برش
      onProgress?.call('cropping', 0.5);
      OmniLogger.info(
          title: "ScannerService",
          message: "تصویر انتخاب شد. شروع فرآیند برش (Crop)...");

      // ۴. اجرای عملیات برش تصویر
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'تنظیم لبه‌های سند',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'تنظیم لبه‌های سند',
            cancelButtonTitle: 'لغو',
            doneButtonTitle: 'تایید',
            aspectRatioLockEnabled: false,
          ),
        ],
      );

      if (croppedFile == null) {
        OmniLogger.info(
            title: "ScannerService", message: "کاربر از مرحله برش انصراف داد.");
        return OmniResponse.error("برش تصویر انجام نشد.");
      }

      // ۵. اتمام عملیات سرویس
      onProgress?.call('cropping', 1.0);

      final File finalFile = File(croppedFile.path);
      if (!await finalFile.exists()) {
        throw const FileSystemException("فایل نهایی یافت نشد.");
      }

      OmniLogger.info(
          title: "ScannerService",
          message: "فرآیند اسکن با موفقیت به پایان رسید: ${finalFile.path}");

      return OmniResponse.success(finalFile,
          message: "تصویر با موفقیت آماده شد.");
    } catch (e, stack) {
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
