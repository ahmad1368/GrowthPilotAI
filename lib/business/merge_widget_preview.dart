/// Pure map-merge for one preview update (Issue #116), kept out of
/// [WidgetPreviewController] so the debounced write path stays testable
/// without any GetX/store setup.
class MergeWidgetPreview {
  static Map<String, Map<String, bool>> call(
    Map<String, Map<String, bool>> previews,
    String widgetId,
    String key,
    bool value,
  ) {
    final updated = {...previews};
    updated[widgetId] = {...?updated[widgetId], key: value};
    return updated;
  }
}
