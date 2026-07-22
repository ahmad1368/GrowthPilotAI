import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/widget_config_option.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_controls.dart';

void main() {
  const options = [
    WidgetConfigOption(key: 'a', label: 'Option A'),
    WidgetConfigOption(key: 'b', label: 'Option B', defaultValue: false),
  ];

  testWidgets('renders one switch per option, reflecting the resolved values',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: WidgetConfigControls(
          options: options,
          values: const {'a': true},
          onChanged: (_, __) {},
        ),
      ),
    ));

    final switches =
        tester.widgetList<SwitchListTile>(find.byType(SwitchListTile));
    expect(switches.length, 2);
    expect(switches.elementAt(0).value, true);
    expect(switches.elementAt(1).value, false); // falls back to default
  });

  testWidgets('tapping a switch calls onChanged with the new value',
      (tester) async {
    String? changedKey;
    bool? changedValue;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: WidgetConfigControls(
          options: options,
          values: const {'a': true},
          onChanged: (key, value) {
            changedKey = key;
            changedValue = value;
          },
        ),
      ),
    ));

    await tester.tap(find.byType(SwitchListTile).first);
    await tester.pump();

    expect(changedKey, 'a');
    expect(changedValue, false); // option A is currently true, so toggles off
  });
}
