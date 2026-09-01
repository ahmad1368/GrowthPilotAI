import 'dart:convert';

import 'package:growth_pilot_ai/core/interfaces/dashboard_template_store.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Real [DashboardTemplateStore] backed by the existing cross-platform
/// [SecureStorageService] (Issue #118), mirroring [SecureWidgetLayoutStore]'s
/// approach under a separate backup-only key.
class SecureDashboardTemplateStore implements DashboardTemplateStore {
  static const _key = 'business_compass_layout_backup';

  @override
  Future<void> backupLayout(List<WidgetLayout> layout) async {
    final encoded = jsonEncode(layout.map((w) => w.toJson()).toList());
    await SecureStorageService.writeData(_key, encoded);
  }

  @override
  Future<List<WidgetLayout>?> loadBackup() async {
    final raw = await SecureStorageService.readData(_key);
    if (raw == null) return null;
    final decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => WidgetLayout.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
