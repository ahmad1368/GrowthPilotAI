import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_widget_config_value.dart';

void main() {
  test('returns the saved value when the widget/key has one', () {
    final result = ResolveWidgetConfigValue.call(
      {
        'RADAR_CHART': {'showBenchmark': false}
      },
      'RADAR_CHART',
      'showBenchmark',
      true,
    );

    expect(result, false);
  });

  test('falls back when the widget has values but not this key', () {
    final result = ResolveWidgetConfigValue.call(
      {
        'RADAR_CHART': {'otherKey': false}
      },
      'RADAR_CHART',
      'showBenchmark',
      true,
    );

    expect(result, true);
  });

  test('falls back when the widget has no saved values at all', () {
    final result =
        ResolveWidgetConfigValue.call({}, 'RADAR_CHART', 'showBenchmark', true);

    expect(result, true);
  });
}
