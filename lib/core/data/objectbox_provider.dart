import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../objectbox.g.dart'; // فایل تولید شده در مرحله قبل

class ObjectBox {
  /// دیتابیس اصلی ما
  late final Store store;

  // سازنده خصوصی برای جلوگیری از ساخت نمونه‌های تصادفی (Singleton Pattern)
  ObjectBox._create(this.store);

  /// متد اصلی برای راه‌اندازی دیتابیس
  static Future<ObjectBox> create() async {
    // پیدا کردن پوشه اسناد اپلیکیشن (امن و خصوصی)
    final docsDir = await getApplicationDocumentsDirectory();

    // تعریف مسیر اختصاصی برای دیتابیس GrowthPilotAI
    final storePath = p.join(docsDir.path, "obx-growth-pilot-db");

    // باز کردن استور (این تابع در objectbox.g.dart تولید شده است)
    final store = await openStore(directory: storePath);

    return ObjectBox._create(store);
  }
}
