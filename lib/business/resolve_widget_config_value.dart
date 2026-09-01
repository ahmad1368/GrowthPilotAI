/// Looks up a single config value for a widget (Issue #115), falling back
/// to [fallback] when the widget has no saved value yet, or hasn't been
/// configured at all.
class ResolveWidgetConfigValue {
  static bool call(
    Map<String, Map<String, bool>> allValues,
    String widgetId,
    String key,
    bool fallback,
  ) {
    return allValues[widgetId]?[key] ?? fallback;
  }
}
