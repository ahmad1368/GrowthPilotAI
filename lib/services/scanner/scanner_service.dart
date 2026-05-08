import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ScannerService {
  final ImagePicker _picker = ImagePicker();

  /// ۱. متد درخواست مجوزها (دوربین و گالری)
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos, // مخصوص اندروید ۱۳ به بالا
    ].request();

    return statuses[Permission.camera]!.isGranted &&
        (statuses[Permission.storage]!.isGranted ||
            statuses[Permission.photos]!.isGranted);
  }

  /// ۲. متد اصلی: زنجیره انتخاب، برش و ذخیره دائمی
  Future<File?> pickAndCrop(ImageSource source, BuildContext context) async {
    try {
      // الف) بررسی مجوزها
      bool hasPermission = await requestPermissions();
      if (!hasPermission) {
        debugPrint("🚫 مجوزهای لازم صادر نشده است");
        return null;
      }

      // ب) انتخاب تصویر از منبع (دوربین یا گالری)
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
// ۱. تنظیم کیفیت بر اساس Requirement شماره ۲۱
        // این مقدار باعث می‌شود حجم فایل به شدت کاهش یابد بدون اینکه نویز پیکسلی ایجاد شود
        imageQuality: 85,

        // ۲. محدود کردن ابعاد برای جلوگیری از کرش در تصاویر بسیار بزرگ (4K)
        // معمولاً ۱۸۰۰ پیکسل برای OCR رسیدها عالی است
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile == null) return null;
// ... کدهای قبلی متد pickAndCrop ...

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            // ۱. تیتر بالای صفحه برش
            toolbarTitle: 'تنظیم لبه‌های رسید',

            // ۲. رنگ پس‌زمینه نوار ابزار (مطابق با تم تیره شما)
            toolbarColor: const Color(0xFF121212),

            // ۳. رنگ متن‌ها و آیکون‌های نوار ابزار (فیروزه‌ای)
            toolbarWidgetColor: Colors.cyanAccent,

            // ۴. رنگ دکمه‌های کنترلی فعال مثل چرخش و تایید
            activeControlsWidgetColor: Colors.cyanAccent,

            // ۵. رنگ نوار وضعیت (StatusBar) بالای گوشی
            statusBarColor: const Color(0xFF000000),

            // ۶. رنگ پس‌زمینه اصلی محیط برش
            backgroundColor: const Color(0xFF121212),

            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'تنظیم لبه‌های رسید',
            aspectRatioLockEnabled: false,
            resetAspectRatioEnabled: true,
            // در iOS سیستم تم‌دهی محدودتر است اما تیتر را هماهنگ کردیم
          ),
        ],
      );

// ... ادامه منطق ذخیره‌سازی ...

      if (croppedFile == null) return null;

      // د) تبدیل به شیء File و انتقال به حافظه دائمی
      final File tempFile = File(croppedFile.path);
      final File permanentFile = await saveFilePermanently(tempFile);

      // هـ) پاک‌سازی فایل موقت کش (بهینه‌سازی حافظه)
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      return permanentFile;
    } catch (e) {
      debugPrint("🔥 خطا در ScannerService: $e");
      return null;
    }
  }

  /// ۳. متد کمکی برای انتقال فایل از کش موقت به پوشه دائمی اپلیکیشن
  Future<File> saveFilePermanently(File tempFile) async {
    // دریافت مسیر پوشه Documents (دائمی و خصوصی برای اپلیکیشن)
    final directory = await getApplicationDocumentsDirectory();

    // ایجاد نام منحصر به فرد با استفاده از برچسب زمانی (Timestamp)
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String extension = p.extension(tempFile.path);
    final String fileName = "receipt_$timestamp$extension";

    // تعریف مسیر کامل جدید و کپی کردن فایل
    final String permanentPath = p.join(directory.path, fileName);
    final File permanentFile = await tempFile.copy(permanentPath);

    debugPrint("📂 فایل با موفقیت ذخیره دائمی شد: $permanentPath");

    return permanentFile;
  }
}
