import 'dart:convert';

import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Real [WidgetLayoutStore] backed by the existing cross-platform
/// [SecureStorageService] (Issue #114) — no backend "Secure Local Storage"
/// pipeline (#106) exists in this repo, so the layout itself is just a
/// small JSON blob under one key.
class SecureWidgetLayoutStore implements WidgetLayoutStore {
  static const _key = 'business_compass_widget_layout';

  @override
  Future<List<WidgetLayout>?> load() async {
    final raw = await SecureStorageService.readData(_key);
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => WidgetLayout.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> save(List<WidgetLayout> layout) async {
    final encoded = jsonEncode(layout.map((w) => w.toJson()).toList());
    await SecureStorageService.writeData(_key, encoded);
  }
}
