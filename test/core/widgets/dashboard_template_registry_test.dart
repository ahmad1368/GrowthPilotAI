import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_template_registry.dart';

void main() {
  test('has at least the three named archetypes from the issue', () {
    final ids = DashboardTemplateRegistry.all.map((t) => t.id).toSet();

    expect(ids, containsAll(['bargain_hunter', 'neighborhood_expert', 'trend_watcher']));
  });

  test('every template ships a non-empty, uniquely-widgeted layout', () {
    for (final template in DashboardTemplateRegistry.all) {
      expect(template.layout, isNotEmpty);
      final widgetIds = template.layout.map((w) => w.widgetId).toSet();
      expect(widgetIds.length, template.layout.length,
          reason: '${template.id} has duplicate widgetIds');
    }
  });

  test('template ids are unique', () {
    final ids = DashboardTemplateRegistry.all.map((t) => t.id).toList();
    expect(ids.toSet().length, ids.length);
  });
}
