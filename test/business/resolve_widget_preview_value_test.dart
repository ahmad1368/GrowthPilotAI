import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_widget_preview_value.dart';

void main() {
  test('returns the dirty preview value when the widget/key has one', () {
    final result = ResolveWidgetPreviewValue.call(
      {
        'RADAR_CHART': {'showBenchmark': false}
      },
      'RADAR_CHART',
      'showBenchmark',
      true, // saved value
    );

    expect(result, false);
  });

  test('falls back to the saved value when the widget has no preview at all', () {
    final result =
        ResolveWidgetPreviewValue.call({}, 'RADAR_CHART', 'showBenchmark', true);

    expect(result, true);
  });

  test('falls back to the saved value when this key is not dirty', () {
    final result = ResolveWidgetPreviewValue.call(
      {
        'RADAR_CHART': {'otherKey': false}
      },
      'RADAR_CHART',
      'showBenchmark',
      true,
    );

    expect(result, true);
  });
}
