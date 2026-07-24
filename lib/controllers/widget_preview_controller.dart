import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/merge_widget_preview.dart';
import 'package:growth_pilot_ai/business/resolve_widget_preview_value.dart';
import 'package:growth_pilot_ai/controllers/widget_config_controller.dart';
import 'package:growth_pilot_ai/core/utils/debouncer.dart';

/// "Live Preview" bridge for the config side-panel (Issue #116): holds
/// unsaved "dirty" values per widget so charts react instantly, without
/// writing to [WidgetConfigController]'s store on every change.
class WidgetPreviewController extends GetxController {
  final WidgetConfigController _config;
  WidgetPreviewController(this._config);

  final previews = <String, Map<String, bool>>{}.obs;
  final _debouncers = <String, Debouncer>{};

  bool valueFor(String widgetId, String key, bool fallback) {
    final saved = _config.valueFor(widgetId, key, fallback);
    return ResolveWidgetPreviewValue.call(previews, widgetId, key, saved);
  }

  bool isPreviewing(String widgetId) => previews[widgetId]?.isNotEmpty ?? false;

  /// 150ms debounce per widget/key so rapid input settles first.
  void updatePreview(String widgetId, String key, bool value) {
    final d = _debouncers.putIfAbsent(
        '$widgetId.$key', () => Debouncer(const Duration(milliseconds: 150)));
    d.run(() => previews.value =
        MergeWidgetPreview.call(previews, widgetId, key, value));
  }

  Future<void> apply(String widgetId) async {
    final dirty = previews[widgetId];
    if (dirty == null) return;
    for (final e in dirty.entries) {
      await _config.setValue(widgetId, e.key, e.value);
    }
    discard(widgetId);
  }

  void discard(String widgetId) =>
      previews.value = {...previews}..remove(widgetId);
  void discardAll() => previews.value = {};

  @override
  void onClose() {
    for (final d in _debouncers.values) { d.dispose(); }
    super.onClose();
  }
}
