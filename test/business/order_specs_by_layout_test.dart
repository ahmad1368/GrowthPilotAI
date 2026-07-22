import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/order_specs_by_layout.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

void main() {
  const specs = [
    ReportWidgetSpec(id: 'RADAR_CHART', title: 'r', data: {}),
    ReportWidgetSpec(id: 'INSIGHT_TEXT', title: 'i', data: {}),
    ReportWidgetSpec(id: 'METRIC_LEGEND', title: 'm', data: {}),
  ];

  test('reorders specs to match the saved layout order', () {
    final layout = [
      const WidgetLayout(widgetId: 'METRIC_LEGEND', position: 0),
      const WidgetLayout(widgetId: 'RADAR_CHART', position: 1),
      const WidgetLayout(widgetId: 'INSIGHT_TEXT', position: 2),
    ];

    final ordered = OrderSpecsByLayout.call(specs, layout);

    expect(ordered.map((s) => s.id).toList(),
        ['METRIC_LEGEND', 'RADAR_CHART', 'INSIGHT_TEXT']);
  });

  test('drops layout entries with no matching spec instead of crashing', () {
    final layout = [
      const WidgetLayout(widgetId: 'RADAR_CHART', position: 0),
      const WidgetLayout(widgetId: 'REMOVED_WIDGET', position: 1),
    ];

    final ordered = OrderSpecsByLayout.call(specs, layout);

    expect(ordered.map((s) => s.id).toList(), ['RADAR_CHART']);
  });
}
