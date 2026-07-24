import 'package:growth_pilot_ai/business/resolve_widget_config_value.dart';

/// Resolves the value a chart should render right now (Issue #116): the
/// unsaved "dirty" preview value while the user is actively previewing,
/// otherwise [savedValue] (the last value written to Secure Storage).
class ResolveWidgetPreviewValue {
  static bool call(
    Map<String, Map<String, bool>> previews,
    String widgetId,
    String key,
    bool savedValue,
  ) {
    final dirty = previews[widgetId];
    if (dirty != null && dirty.containsKey(key)) {
      return ResolveWidgetConfigValue.call(previews, widgetId, key, savedValue);
    }
    return savedValue;
  }
}
