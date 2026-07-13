import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/forecast_chart.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/forecast_line_builder.dart';

void main() {
  group('ForecastLineBuilder', () {
    test('emits two bars and joins forecast at the historical pivot', () {
      final bars = ForecastLineBuilder.build(
          [10.0, 20.0, 30.0], [40.0, 50.0], Colors.red);
      expect(bars.length, 2);
      // Historical solid line has no dash; forecast is dashed.
      expect(bars[0].dashArray, isNull);
      expect(bars[1].dashArray, isNotNull);
      // Forecast starts at the last historical point (pivot) for continuity.
      expect(bars[1].spots.first.x, 2);
      expect(bars[1].spots.first.y, 30.0);
    });
  });

  testWidgets('ForecastChart renders a LineChart in light and dark',
      (tester) async {
    for (final brightness in [Brightness.light, Brightness.dark]) {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(brightness: brightness),
        home: const Scaffold(
          body: ForecastChart(
            historical: [10, 20, 30, 40],
            forecast: [50, 60],
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(LineChart), findsOneWidget);
    }
  });
}
