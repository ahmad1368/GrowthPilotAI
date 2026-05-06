import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../services/secure_storage_service.dart';
import '../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  static const _keyName = 'db_encryption_key_v1';

  ObjectBox._create(this.store);

  /// تولید یا بازیابی کلید با استفاده از سرویس اختصاصی
  static Future<Uint8List> _getOrCreateKey() async {
    // استفاده از سرویس برای خواندن کلید
    String? keyBase64 = await SecureStorageService.readData(_keyName);

    if (keyBase64 == null) {
      // تولید کلید ۳۲ بایتی امن
      final random = Random.secure();
      final key =
          Uint8List.fromList(List.generate(32, (_) => random.nextInt(256)));

      // ذخیره کلید از طریق سرویس
      await SecureStorageService.writeData(_keyName, base64Encode(key));

      return key;
    }

    return base64Decode(keyBase64);
  }

  /// متد ساخت دیتابیس
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    // در نسخه رایگان ObjectBox، پارامتر password وجود ندارد.
    // اگر نیاز به امنیت بالا دارید، باید فیلدهای حساس مدل‌ها را رمزنگاری کنید.

    final store = await openStore(
      directory: p.join(docsDir.path, "obx-growth-db"),
      // password: encryptionKey, <-- این خط باعث خطا می‌شود و حذف شد
      macosApplicationGroup: "group.com.growthpilot.app",
    );

    return ObjectBox._create(store);
  }

  void close() {
    store.close();
  }
}
