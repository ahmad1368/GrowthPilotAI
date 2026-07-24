import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/widgets/lazy_widget_wrapper.dart';
import 'package:growth_pilot_ai/core/widgets/widget_shimmer_loader.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    // Fire visibility callbacks every frame instead of the default 500ms
    // batching, so tests don't need to fake-advance the clock.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('shows the shimmer for content that has never scrolled into view',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 10,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 2000), // pushes the target off-screen
              LazyWidgetWrapper(widgetId: 'RADAR_CHART', child: Text('Real content')),
            ]),
          ),
        ),
      ),
    ));
    await tester.pump();

    expect(find.byType(WidgetShimmerLoader), findsOneWidget);
    expect(find.text('Real content'), findsNothing);
  });

  testWidgets('shows the real child once it scrolls into view', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LazyWidgetWrapper(widgetId: 'RADAR_CHART', child: Text('Real content')),
      ),
    ));
    await tester.pump();

    expect(find.text('Real content'), findsOneWidget);
    expect(find.byType(WidgetShimmerLoader), findsNothing);
  });
}
