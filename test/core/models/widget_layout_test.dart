import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

void main() {
  test('toJson/fromJson round-trips every field', () {
    const layout = WidgetLayout(
        widgetId: 'RADAR_CHART',
        position: 2,
        crossAxisSpan: 2,
        isLocked: true);

    final restored = WidgetLayout.fromJson(layout.toJson());

    expect(restored.widgetId, 'RADAR_CHART');
    expect(restored.position, 2);
    expect(restored.crossAxisSpan, 2);
    expect(restored.isLocked, true);
  });

  test('fromJson defaults crossAxisSpan and isLocked when absent', () {
    final restored =
        WidgetLayout.fromJson({'widgetId': 'INSIGHT_TEXT', 'position': 0});

    expect(restored.crossAxisSpan, 1);
    expect(restored.isLocked, false);
  });

  test('copyWith only changes position', () {
    const layout = WidgetLayout(
        widgetId: 'x', position: 0, crossAxisSpan: 2, isLocked: true);

    final moved = layout.copyWith(position: 5);

    expect(moved.position, 5);
    expect(moved.widgetId, 'x');
    expect(moved.crossAxisSpan, 2);
    expect(moved.isLocked, true);
  });
}
