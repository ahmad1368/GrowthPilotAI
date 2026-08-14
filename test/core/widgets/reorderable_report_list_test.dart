import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/reorderable_report_list.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

void main() {
  setUp(() {
    ReportWidgetRegistry.register(
        'TEST', (spec) => Text(spec.data['label'] as String));
  });

  const specsById = {
    'a': ReportWidgetSpec(id: 'TEST', title: 't', data: {'label': 'A'}),
    'b': ReportWidgetSpec(id: 'TEST', title: 't', data: {'label': 'B'}),
  };

  testWidgets('every unlocked entry gets a drag start listener',
      (tester) async {
    final layout = [
      const WidgetLayout(widgetId: 'a', position: 0),
      const WidgetLayout(widgetId: 'b', position: 1),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ReorderableReportList(
            layout: layout, specsById: specsById, onReorder: (_, __) {}),
      ),
    ));

    expect(find.byType(ReorderableDragStartListener), findsNWidgets(2));
  });

  testWidgets('a locked entry gets no drag start listener', (tester) async {
    final layout = [
      const WidgetLayout(widgetId: 'a', position: 0, isLocked: true),
      const WidgetLayout(widgetId: 'b', position: 1),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ReorderableReportList(
            layout: layout, specsById: specsById, onReorder: (_, __) {}),
      ),
    ));

    expect(find.byType(ReorderableDragStartListener), findsNWidgets(1));
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });
}
