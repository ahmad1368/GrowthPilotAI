import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/widget_config_option.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_registry.dart';

void main() {
  test('optionsFor returns the registered options for a widget id', () {
    WidgetConfigRegistry.register('TEST_WIDGET_A', const [
      WidgetConfigOption(key: 'flag', label: 'Flag'),
    ]);

    final options = WidgetConfigRegistry.optionsFor('TEST_WIDGET_A');

    expect(options, hasLength(1));
    expect(options.single.key, 'flag');
  });

  test('optionsFor returns an empty list for an unregistered id', () {
    expect(WidgetConfigRegistry.optionsFor('NEVER_REGISTERED'), isEmpty);
  });
}
