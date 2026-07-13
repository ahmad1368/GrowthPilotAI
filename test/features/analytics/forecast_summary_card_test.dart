import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/forecast_empty_state.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/forecast_summary_card.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('shows the projected total when there is enough history',
      (tester) async {
    await tester.pumpWidget(_wrap(const ForecastSummaryCard(
      history: [40, 52, 48, 61, 55, 70, 66],
      forecast: [72, 74, 76, 78, 80, 82, 84],
    )));
    await tester.pumpAndSettle();

    expect(find.textContaining('PROJECTED'), findsOneWidget);
    // 7-day total 72+74+76+78+80+82+84 = 546 -> "$546.00".
    expect(find.textContaining(r'$546.00'), findsOneWidget);
    expect(find.byType(ForecastEmptyState), findsNothing);
  });

  testWidgets('shows the empty state with insufficient history',
      (tester) async {
    await tester.pumpWidget(_wrap(const ForecastSummaryCard(
      history: [10, 0, 0],
      forecast: [5, 5, 5],
    )));
    await tester.pumpAndSettle();

    expect(find.byType(ForecastEmptyState), findsOneWidget);
    expect(find.textContaining('Scan more receipts'), findsOneWidget);
  });

  testWidgets('privacy toggle masks the amount', (tester) async {
    await tester.pumpWidget(_wrap(const ForecastSummaryCard(
      history: [40, 52, 48, 61, 55, 70, 66],
      forecast: [72, 74, 76, 78, 80, 82, 84],
    )));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pumpAndSettle();
    expect(find.textContaining(r'$546.00'), findsNothing);
    expect(find.textContaining('••••'), findsOneWidget);
  });

  testWidgets('what-if chip switches the window to 3 days', (tester) async {
    await tester.pumpWidget(_wrap(const ForecastSummaryCard(
      history: [40, 52, 48, 61, 55, 70, 66],
      forecast: [72, 74, 76, 78, 80, 82, 84],
    )));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next 3 days'));
    await tester.pumpAndSettle();
    // 3-day total 72+74+76 = 222.
    expect(find.textContaining(r'$222.00'), findsOneWidget);
    expect(find.textContaining('NEXT 3 DAYS'), findsOneWidget);
  });
}
