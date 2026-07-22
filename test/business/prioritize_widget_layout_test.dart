import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/prioritize_widget_layout.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

WidgetLayout _w(String id, int pos, {bool locked = false}) =>
    WidgetLayout(widgetId: id, position: pos, isLocked: locked);

void main() {
  test('floats locked widgets to the front, preserving their relative order',
      () {
    final layout = [
      _w('unlocked-1', 0),
      _w('locked-1', 1, locked: true),
      _w('unlocked-2', 2),
      _w('locked-2', 3, locked: true),
    ];

    final result = PrioritizeWidgetLayout.call(layout);

    expect(result.map((w) => w.widgetId).toList(),
        ['locked-1', 'locked-2', 'unlocked-1', 'unlocked-2']);
    expect(result.map((w) => w.position).toList(), [0, 1, 2, 3]);
  });

  test('is a no-op ordering when nothing is locked', () {
    final layout = [_w('a', 0), _w('b', 1)];

    final result = PrioritizeWidgetLayout.call(layout);

    expect(result.map((w) => w.widgetId).toList(), ['a', 'b']);
  });
}
