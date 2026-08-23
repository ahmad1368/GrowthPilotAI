import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';

/// Wipes every local ObjectBox record (Issue #189: App Store 5.1.1(v)
/// requires in-app account deletion). This is a local-first app with no
/// cloud backend to also purge — deleting the on-device store IS
/// deleting the account. No-op on web (ObjectBox has no web backend
/// here; nothing to delete). The app must be restarted afterward — an
/// already-open [ObjectBox.store] can't be safely swapped out from
/// under the repositories that already captured a reference to it.
class DeleteAllLocalData {
  static Future<void> call(ObjectBox objectBox) async {
    if (kIsWeb) return;
    objectBox.close();
    final docsDir = await getApplicationDocumentsDirectory();
    final storeDir = Directory(p.join(docsDir.path, "obx-growth-pilot-db"));
    if (await storeDir.exists()) await storeDir.delete(recursive: true);
  }
}
