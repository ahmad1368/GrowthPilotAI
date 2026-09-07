import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/forecast_days_input.dart';

/// [Issue #810] Not executed by this pipeline — run manually with
/// `flutter test` when ready.
void main() {
  testWidgets('typing a valid day count notifies onChanged with the parsed value', (tester) async {
    int? notified;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ForecastDaysInput(days: 7, onChanged: (d) => notified = d),
      ),
    ));

    await tester.enterText(find.byType(TextField), '14');
    expect(notified, 14);
  });

  testWidgets('a value above maxDays is clamped', (tester) async {
    int? notified;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ForecastDaysInput(days: 7, onChanged: (d) => notified = d),
      ),
    ));

    await tester.enterText(find.byType(TextField), '999');
    expect(notified, ForecastDaysInput.maxDays);
  });

  testWidgets('clearing the field does not notify or crash', (tester) async {
    int? notified;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ForecastDaysInput(days: 7, onChanged: (d) => notified = d),
      ),
    ));

    await tester.enterText(find.byType(TextField), '');
    expect(notified, isNull);
    expect(tester.takeException(), isNull);
  });
}
