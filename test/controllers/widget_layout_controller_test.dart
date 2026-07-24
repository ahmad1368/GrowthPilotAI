import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

class _InMemoryWidgetLayoutStore implements WidgetLayoutStore {
  List<WidgetLayout>? saved;
  @override
  Future<List<WidgetLayout>?> load() async => saved;
  @override
  Future<void> save(List<WidgetLayout> layout) async => saved = List.of(layout);
}

void main() {
  // setLayout is new for Issue #118 (applying/restoring a Dashboard
  // Template); reorder is re-tested here since it was refactored to reuse
  // setLayout rather than duplicating the save+prioritize logic.
  test('setLayout persists and re-applies lock priority', () async {
    final store = _InMemoryWidgetLayoutStore();
    final controller = WidgetLayoutController(store);

    await controller.setLayout(const [
      WidgetLayout(widgetId: 'a', position: 0),
      WidgetLayout(widgetId: 'b', position: 1, isLocked: true),
    ]);

    expect(controller.layout.map((w) => w.widgetId), ['b', 'a']);
    expect(store.saved?.map((w) => w.widgetId), ['b', 'a']);
  });

  test('reorder still moves an unlocked widget and persists', () async {
    final store = _InMemoryWidgetLayoutStore();
    final controller = WidgetLayoutController(store);
    await controller.loadFor(['a', 'b', 'c']);

    await controller.reorder(0, 2);

    expect(controller.layout.map((w) => w.widgetId), ['b', 'a', 'c']);
    expect(store.saved, isNotNull);
  });
}
