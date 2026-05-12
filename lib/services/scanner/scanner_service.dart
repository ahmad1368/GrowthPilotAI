import 'dart:io';
import 'package:flutter/material.dart';
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
  Future<File?> pickAndCrop(
    ImageSource source,
    BuildContext context, {
    ScanProgressCallback? onProgress,
  }) async {
    try {
      // الف) شروع مرحله انتخاب
      onProgress?.call('pick', 0.1); // شروع انتخاب

      bool hasPermission = await requestPermissions();
      if (!hasPermission) {
        debugPrint("🚫 مجوزهای لازم صادر نشده است");
        return null;
      }

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile == null) return null;
      onProgress?.call('pick', 1.0); // پایان انتخاب

      // ب) مدیریت وب
      if (kIsWeb) {
        onProgress?.call('done', 1.0);
        return File(pickedFile.path);
      }

      // ج) شروع مرحله برش (Crop)
      onProgress?.call('crop', 0.2); // ورود به صفحه برش

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'تنظیم لبه‌های سند',
            toolbarColor: const Color(0xFF121212),
            toolbarWidgetColor: Colors.cyanAccent,
            activeControlsWidgetColor: Colors.cyanAccent,
            statusBarColor: const Color(0xFF000000),
            backgroundColor: const Color(0xFF121212),
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'تنظیم لبه‌های سند',
            aspectRatioLockEnabled: false,
            resetAspectRatioEnabled: true,
          ),
        ],
      );

      if (croppedFile == null) return null;
      onProgress?.call('crop', 1.0); // پایان برش

      // د) ذخیره سازی دائمی
      onProgress?.call(
          'ai', 0.1); // آماده‌سازی برای پردازش هوشمند (شروع مرحله بعد)

      final File tempFile = File(croppedFile.path);
      final File permanentFile = await saveFilePermanently(tempFile);

      // پاک‌سازی فایل موقت
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      return permanentFile;
    } catch (e) {
      debugPrint("🔥 خطا در ScannerService: $e");
      return null;
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
