import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/prioritize_widget_layout.dart';
import 'package:growth_pilot_ai/business/reorder_widget_layout.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

/// Drives the Business Compass reorder mode (Issue #114): loads any saved
/// custom order (falling back to [widgetIds] in that default order), keeps
/// locked widgets pinned to the front, and persists after every drag.
class WidgetLayoutController extends GetxController {
  final WidgetLayoutStore _store;
  WidgetLayoutController(this._store);

  final layout = <WidgetLayout>[].obs;

  Future<void> loadFor(List<String> widgetIds) async {
    final saved = await _store.load();
    final base = saved ?? [
      for (var i = 0; i < widgetIds.length; i++)
        WidgetLayout(widgetId: widgetIds[i], position: i)
    ];
    layout.value = PrioritizeWidgetLayout.call(base);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    await setLayout(PrioritizeWidgetLayout.call(
        ReorderWidgetLayout.call(layout, oldIndex, newIndex)));
  }

  /// Overwrites the layout wholesale (Issue #118: applying/restoring a
  /// Dashboard Template), keeping locked widgets pinned to the front.
  Future<void> setLayout(List<WidgetLayout> newLayout) async {
    layout.value = PrioritizeWidgetLayout.call(newLayout);
    await _store.save(layout);
  }
}
