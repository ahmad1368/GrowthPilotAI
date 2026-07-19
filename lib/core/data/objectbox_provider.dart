import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
// این خط را حتماً برگردان تا Store شناسایی شود
import '../../objectbox.g.dart'; // این خط تا زمانی که دستور ترمینال تمام نشود، قرمز می‌ماند

/// Store singleton (Issue #11): opened once in `main.dart` before `runApp`
/// and registered permanently in GetIt, so every repository shares the same
/// [Store] instance.
class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final storePath = p.join(docsDir.path, "obx-growth-pilot-db");

      // این متد در فایل g.dart ساخته خواهد شد
      final store = await openStore(directory: storePath);

      return ObjectBox._create(store);
    } catch (e, stack) {
      OmniLogger.error(
        title: "ObjectBox Store Failed to Open",
        widgetName: "ObjectBox",
        message: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  void close() => store.close();
}
