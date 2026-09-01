import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/dynamic_report_gallery.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';

void main() {
  setUp(() {
    ReportWidgetRegistry.register(
        'TEST_TEXT', (spec) => Text(spec.data['label'] as String));
  });

  test('build() renders the registered widget for a known id', () {
    const spec =
        ReportWidgetSpec(id: 'TEST_TEXT', title: 't', data: {'label': 'hi'});

    final widget = ReportWidgetRegistry.build(spec);

    expect(widget, isA<Text>());
    expect((widget as Text).data, 'hi');
  });

  test('build() returns an empty box for an unknown id instead of crashing',
      () {
    const spec = ReportWidgetSpec(id: 'NOPE', title: 't', data: {});

    final widget = ReportWidgetRegistry.build(spec);

    expect(widget, isA<SizedBox>());
  });

  testWidgets('DynamicReportGallery renders every spec in order',
      (tester) async {
    const specs = [
      ReportWidgetSpec(id: 'TEST_TEXT', title: 'a', data: {'label': 'first'}),
      ReportWidgetSpec(id: 'TEST_TEXT', title: 'b', data: {'label': 'second'}),
      ReportWidgetSpec(id: 'NOPE', title: 'c', data: {}),
    ];

    await tester.pumpWidget(const MaterialApp(
      home: DynamicReportGallery(specs: specs),
    ));

    expect(find.text('first'), findsOneWidget);
    expect(find.text('second'), findsOneWidget);
  });
}
