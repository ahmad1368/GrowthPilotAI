import 'package:growth_pilot_ai/core/models/widget_layout.dart';

/// Stashes the user's layout before a Dashboard Template (Issue #118)
/// overwrites it, so their "Custom" arrangement can be restored later —
/// separate from [WidgetLayoutStore] since it's a backup slot, not the
/// live layout.
abstract class DashboardTemplateStore {
  Future<void> backupLayout(List<WidgetLayout> layout);
  Future<List<WidgetLayout>?> loadBackup();
}
