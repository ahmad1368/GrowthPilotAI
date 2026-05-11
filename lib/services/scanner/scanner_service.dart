import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' show kIsWeb;

class ScannerService {
  final ImagePicker _picker = ImagePicker();

  /// ۱. متد درخواست مجوزها (فقط برای موبایل)
  Future<bool> requestPermissions() async {
    // در وب نیازی به درخواست مجوز از طریق permission_handler نیست
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

  /// ۲. متد اصلی: زنجیره انتخاب و برش (سازگار با وب و موبایل)
  Future<File?> pickAndCrop(ImageSource source, BuildContext context) async {
    try {
      // الف) بررسی مجوزها (در وب همیشه true برمی‌گرداند)
      bool hasPermission = await requestPermissions();
      if (!hasPermission) {
        debugPrint("🚫 مجوزهای لازم صادر نشده است");
        return null;
      }

      // ب) انتخاب تصویر
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile == null) return null;

      // ج) مدیریت وب: در وب برش و ذخیره دائمی محلی نداریم
      if (kIsWeb) {
        debugPrint("🌐 حالت وب: عبور از مرحله برش و ذخیره دائمی");
        return File(pickedFile.path); // مسیر در وب یک Blob URL است
      }

      // د) منطق مخصوص موبایل (برش تصویر)
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'تنظیم لبه‌های رسید',
            toolbarColor: const Color(0xFF121212),
            toolbarWidgetColor: Colors.cyanAccent,
            activeControlsWidgetColor: Colors.cyanAccent,
            statusBarColor: const Color(0xFF000000),
            backgroundColor: const Color(0xFF121212),
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'تنظیم لبه‌های رسید',
            aspectRatioLockEnabled: false,
            resetAspectRatioEnabled: true,
          ),
        ],
      );

      if (croppedFile == null) return null;

      // هـ) ذخیره دائمی (فقط در موبایل)
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

  /// ۳. متد ذخیره دائمی (فقط برای موبایل)
  Future<File> saveFilePermanently(File tempFile) async {
    if (kIsWeb) return tempFile; // در وب ذخیره در فایل‌سیستم نداریم

    final directory = await getApplicationDocumentsDirectory();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String extension = p.extension(tempFile.path);
    final String fileName = "receipt_$timestamp$extension";

    final String permanentPath = p.join(directory.path, fileName);
    final File permanentFile = await tempFile.copy(permanentPath);

    debugPrint("📂 فایل ذخیره دائمی شد: $permanentPath");
    return permanentFile;
  }
}
