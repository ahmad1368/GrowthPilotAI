import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // ایجاد یک نمونه ثابت برای استفاده در کل برنامه
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // تنظیمات اختصاصی اندروید برای امنیت حداکثری
  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  // متد ذخیره‌سازی
  static Future<void> writeData(String key, String value) async {
    await _storage.write(key: key, value: value, aOptions: _androidOptions);
  }

  // متد خواندن داده
  static Future<String?> readData(String key) async {
    return await _storage.read(key: key, aOptions: _androidOptions);
  }

  // متد حذف داده (مثلاً هنگام خروج از حساب کاربری)
  static Future<void> deleteData(String key) async {
    await _storage.delete(key: key, aOptions: _androidOptions);
  }
}
