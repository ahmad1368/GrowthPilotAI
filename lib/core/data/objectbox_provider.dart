import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
// این خط را حتماً برگردان تا Store شناسایی شود
import '../../objectbox.g.dart'; // این خط تا زمانی که دستور ترمینال تمام نشود، قرمز می‌ماند

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final storePath = p.join(docsDir.path, "obx-growth-pilot-db");

    // این متد در فایل g.dart ساخته خواهد شد
    final store = await openStore(directory: storePath);

    return ObjectBox._create(store);
  }
}
