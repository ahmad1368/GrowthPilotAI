import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/resolve_widget_config_value.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_config_store.dart';

/// Drives the Business Compass config side-panel (Issue #115): loads any
/// saved toggle values, resolves a value with its option's default when
/// unset, and persists after every change for instant, saved feedback.
class WidgetConfigController extends GetxController {
  final WidgetConfigStore _store;
  WidgetConfigController(this._store);

  final values = <String, Map<String, bool>>{}.obs;

  Future<void> loadAll() async {
    values.value = await _store.load() ?? {};
  }

  bool valueFor(String widgetId, String key, bool fallback) =>
      ResolveWidgetConfigValue.call(values, widgetId, key, fallback);

  Future<void> setValue(String widgetId, String key, bool value) async {
    final updated = {...values};
    updated[widgetId] = {...?updated[widgetId], key: value};
    values.value = updated;
    await _store.save(updated);
  }
}
