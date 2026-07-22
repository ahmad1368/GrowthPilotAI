import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/reorder_widget_layout.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

WidgetLayout _w(String id, int pos, {bool locked = false}) =>
    WidgetLayout(widgetId: id, position: pos, isLocked: locked);

void main() {
  test('moves a widget from oldIndex to newIndex and renumbers positions',
      () {
    final layout = [_w('a', 0), _w('b', 1), _w('c', 2)];

    final result = ReorderWidgetLayout.call(layout, 0, 2);

    // Standard Flutter ReorderableListView semantics: newIndex is the
    // pre-removal index to insert before, so moving index 0 to 2 lands
    // the item at final index 1, not 2.
    expect(result.map((w) => w.widgetId).toList(), ['b', 'a', 'c']);
    expect(result.map((w) => w.position).toList(), [0, 1, 2]);
  });

  test('moving backwards works the same way', () {
    final layout = [_w('a', 0), _w('b', 1), _w('c', 2)];

    final result = ReorderWidgetLayout.call(layout, 2, 0);

    expect(result.map((w) => w.widgetId).toList(), ['c', 'a', 'b']);
  });

  test('refuses to move a locked widget, returning the layout unchanged',
      () {
    final layout = [_w('a', 0, locked: true), _w('b', 1), _w('c', 2)];

    final result = ReorderWidgetLayout.call(layout, 0, 2);

    expect(result, same(layout));
  });
}
