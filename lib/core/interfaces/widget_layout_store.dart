import 'package:growth_pilot_ai/core/models/widget_layout.dart';

/// Persists a user's custom dashboard widget order (Issue #114) so it
/// survives an app restart.
abstract class WidgetLayoutStore {
  Future<List<WidgetLayout>?> load();
  Future<void> save(List<WidgetLayout> layout);
}
