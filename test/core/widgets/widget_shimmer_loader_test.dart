import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/widgets/widget_shimmer_loader.dart';

void main() {
  testWidgets('renders at the given height', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: WidgetShimmerLoader(height: 120)),
    ));

    final container = tester.widget<Container>(find.byType(Container));
    expect(container.constraints?.maxHeight, 120);
  });

  testWidgets('defaults to a height of 160', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: WidgetShimmerLoader()),
    ));

    final container = tester.widget<Container>(find.byType(Container));
    expect(container.constraints?.maxHeight, 160);
  });
}
