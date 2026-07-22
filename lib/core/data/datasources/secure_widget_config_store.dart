import 'dart:convert';

import 'package:growth_pilot_ai/core/interfaces/widget_config_store.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Real [WidgetConfigStore] backed by the existing cross-platform
/// [SecureStorageService] (Issue #115), same pattern as
/// [SecureWidgetLayoutStore] from Issue #114.
class SecureWidgetConfigStore implements WidgetConfigStore {
  static const _key = 'business_compass_widget_config';

  @override
  Future<Map<String, Map<String, bool>>?> load() async {
    final raw = await SecureStorageService.readData(_key);
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((widgetId, values) => MapEntry(
        widgetId, (values as Map<String, dynamic>).cast<String, bool>()));
  }

  @override
  Future<void> save(Map<String, Map<String, bool>> values) async {
    await SecureStorageService.writeData(_key, jsonEncode(values));
  }
}
