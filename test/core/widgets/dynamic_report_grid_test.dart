import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/dynamic_report_grid.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    ReportWidgetRegistry.register(
        'RADAR_CHART', (spec) => const SizedBox(height: 100));
    ReportWidgetRegistry.register(
        'METRIC_LEGEND', (spec) => const SizedBox(height: 40));
    // Issue #119's LazyWidgetWrapper now wraps every tile in a
    // VisibilityDetector; fire its callback every frame instead of the
    // default 500ms Timer, which flutter_test flags as pending at teardown.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets(
      'a full-width widget and two half-width widgets render without gaps',
      (tester) async {
    const specs = [
      ReportWidgetSpec(id: 'RADAR_CHART', title: 'a', data: {}),
      ReportWidgetSpec(id: 'METRIC_LEGEND', title: 'b', data: {}),
      ReportWidgetSpec(id: 'METRIC_LEGEND', title: 'c', data: {}),
    ];

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: DynamicReportGrid(specs: specs)),
      ),
    ));

    final tiles =
        tester.widgetList<StaggeredGridTile>(find.byType(StaggeredGridTile));
    // Default test viewport is wide (not mobile), so totalColumns == 4.
    expect(tiles.map((t) => t.crossAxisCellCount), [4, 2, 2]);
  });

  testWidgets('narrower (mobile) width still spans a full-width widget fully',
      (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const specs = [ReportWidgetSpec(id: 'RADAR_CHART', title: 'a', data: {})];
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: DynamicReportGrid(specs: specs)),
      ),
    ));

    final tile =
        tester.widget<StaggeredGridTile>(find.byType(StaggeredGridTile));
    expect(tile.crossAxisCellCount, 2); // mobile totalColumns == 2
  });
}
