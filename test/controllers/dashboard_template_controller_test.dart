import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/dashboard_template_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_template_store.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/models/dashboard_template.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

class _InMemoryLayoutStore implements WidgetLayoutStore {
  List<WidgetLayout>? saved;
  @override
  Future<List<WidgetLayout>?> load() async => saved;
  // Copies, not aliases: WidgetLayoutController's `layout` is a live RxList
  // that keeps getting mutated after save() returns.
  @override
  Future<void> save(List<WidgetLayout> layout) async => saved = List.of(layout);
}

class _InMemoryTemplateStore implements DashboardTemplateStore {
  List<WidgetLayout>? backup;
  @override
  Future<void> backupLayout(List<WidgetLayout> layout) async =>
      backup = List.of(layout);
  @override
  Future<List<WidgetLayout>?> loadBackup() async => backup;
}

void main() {
  const template = DashboardTemplate(
    id: 'trend_watcher',
    name: 'The Trend Watcher',
    description: 'desc',
    layout: [WidgetLayout(widgetId: 'INSIGHT_TEXT', position: 0)],
  );

  test('apply backs up the current layout, applies the template, and marks it applied',
      () async {
    final layoutController = WidgetLayoutController(_InMemoryLayoutStore());
    await layoutController.loadFor(['a', 'b']);
    final templateStore = _InMemoryTemplateStore();
    final controller = DashboardTemplateController(layoutController, templateStore);

    await controller.apply(template);

    expect(templateStore.backup?.map((w) => w.widgetId), ['a', 'b']);
    expect(layoutController.layout.map((w) => w.widgetId), ['INSIGHT_TEXT']);
    expect(controller.appliedTemplateId.value, 'trend_watcher');
  });

  test('restoreCustom brings back the backed-up layout and clears the applied id',
      () async {
    final layoutController = WidgetLayoutController(_InMemoryLayoutStore());
    await layoutController.loadFor(['a', 'b']);
    final templateStore = _InMemoryTemplateStore();
    final controller = DashboardTemplateController(layoutController, templateStore);
    await controller.apply(template);

    await controller.restoreCustom();

    expect(layoutController.layout.map((w) => w.widgetId), ['a', 'b']);
    expect(controller.appliedTemplateId.value, isNull);
  });

  test('restoreCustom with no backup is a no-op', () async {
    final layoutController = WidgetLayoutController(_InMemoryLayoutStore());
    await layoutController.loadFor(['a']);
    final controller =
        DashboardTemplateController(layoutController, _InMemoryTemplateStore());

    await controller.restoreCustom();

    expect(layoutController.layout.map((w) => w.widgetId), ['a']);
  });
}
