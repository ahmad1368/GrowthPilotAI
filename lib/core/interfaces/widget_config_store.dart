/// Persists per-widget config toggle values (Issue #115) so they survive
/// an app restart.
abstract class WidgetConfigStore {
  Future<Map<String, Map<String, bool>>?> load();
  Future<void> save(Map<String, Map<String, bool>> values);
}
