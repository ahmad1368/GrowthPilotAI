import 'dart:io';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
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

  /// ۲. متد اصلی با قابلیت گزارش پیشرفت لحظه‌ای
  /// [onProgress] اجازه می‌دهد UI بفهمد دقیقاً در کدام مرحله هستیم.
  /// مرحله انتخاب و برش تصویر
  /// به جای Future<File?> حالا از OmniResult<File> استفاده می‌کنیم
  OmniResult<File> pickAndCrop(
    ImageSource source,
    BuildContext context, {
    void Function(String, double)? onProgress,
  }) async {
    try {
      // ۱. انتخاب تصویر از منبع (دوربین یا گالری)
      onProgress?.call('picking', 0.1);
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // بهینه‌سازی برای OCR
      );

      if (pickedFile == null) {
        return OmniResponse.error("تصویری انتخاب نشد.");
      }

      // ۲. مرحله برش تصویر (Crop)
      onProgress?.call('cropping', 0.5);

      // فرض بر این است که متد برش شما یک فایل برمی‌گرداند
      // در اینجا منطق برش فعلی خود را قرار دهید
      final File imageFile = File(pickedFile.path);

      onProgress?.call('finalizing', 0.9);

      // ۳. خروجی موفقیت‌آمیز
      return OmniResponse.success(imageFile,
          message: "تصویر با موفقیت آماده شد.");
    } catch (e) {
      return OmniResponse.error("خطا در دسترسی به رسانه: ${e.toString()}");
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
